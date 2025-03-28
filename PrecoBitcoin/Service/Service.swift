//
//  Service.swift
//  PrecoBitcoin
//
//  Created by Jean Ramalho on 28/03/25.
//
import Foundation

class Service {
    
    /// Essa função realiza uma requisição para a API que retorna os preços de várias moedas.
    /// Ela extrai o preço de compra (chave "buy") para a moeda BRL e retorna esse valor formatado.
    /// - Parameter completion: Um closure que será chamado quando a requisição terminar, passando uma `String?` com o preço ou uma mensagem de erro.
    func fetchBitcoinPrice(completion: @escaping (String?) -> Void) {
        // 1. Cria uma URL a partir da string da API.
        guard let url = URL(string: "https://blockchain.info/ticker") else {
            // Se a URL for inválida, retorna a mensagem de erro pelo completion.
            completion("URL inválida")
            return
        }
        
        // 2. Cria uma tarefa assíncrona para realizar a requisição.
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // 3. Verifica se houve algum erro na requisição.
            if let error = error {
                print("Erro na requisição: \(error.localizedDescription)")
                completion("Erro na requisição")
                return
            }
            
            // 4. Verifica se os dados foram recebidos.
            guard let data = data else {
                completion("Dados não recebidos!")
                return
            }
            
            do {
                // 5. Converte os dados recebidos em um objeto JSON (dicionário).
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   // 6. Acessa o objeto referente à moeda "BRL".
                   let bitcoinBRL = jsonObject["BRL"] as? [String: Any],
                   // 7. Extrai o valor da chave "buy" como Double.
                   let price = bitcoinBRL["buy"] as? Double {
                    
                    // 8. Converte o valor para NSNumber para poder formatá-lo com NumberFormatter.
                    let numberPrice = NSNumber(value: price)
                    // 9. Chama a função de formatação que retorna uma string com o número formatado de acordo com o padrão brasileiro.
                    let precoFormatado = self.formatarPreco(preco: numberPrice)
                    // 10. Monta a string final com o símbolo de moeda.
                    let formattedString = "R$ \(precoFormatado)"
                    // 11. Chama o completion passando a string formatada.
                    completion(formattedString)
                } else {
                    // Se o JSON não estiver no formato esperado, retorna uma mensagem de erro.
                    completion("Erro ao processar JSON")
                }
                
            } catch {
                // Trata erros na conversão do JSON e retorna a mensagem de erro.
                print("Erro ao converter JSON: \(error.localizedDescription)")
                completion("Erro ao converter JSON")
            }
        }
        
        // 12. Inicia a tarefa de requisição.
        task.resume()
    }
    
    /// Função que formata um NSNumber para uma string com formatação de número decimal e local "pt_BR".
    /// - Parameter preco: O número a ser formatado.
    /// - Returns: Uma string formatada ou "0,00" se a formatação falhar.
    func formatarPreco(preco: NSNumber) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.locale = Locale(identifier: "pt_BR")
        
        if let precoFinal = nf.string(from: preco) {
            return precoFinal
        }
        return "0,00"
    }
}
