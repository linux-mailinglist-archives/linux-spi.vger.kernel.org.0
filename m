Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C907B4EDD
	for <lists+linux-spi@lfdr.de>; Mon,  2 Oct 2023 11:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbjJBJTG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Oct 2023 05:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjJBJTF (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Oct 2023 05:19:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0257E83;
        Mon,  2 Oct 2023 02:19:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E22C433C7;
        Mon,  2 Oct 2023 09:18:57 +0000 (UTC)
Message-ID: <c835120d-8a2f-4542-8df9-4d6a2218ddf1@xs4all.nl>
Date:   Mon, 2 Oct 2023 11:18:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: media: imx-jpeg: Add clocks property
Content-Language: en-US, nl
To:     Mirela Rabulea <mirela.rabulea@nxp.com>,
        Rob Herring <robh@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Conor Dooley <conor@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>,
        Eagle Zhou <eagle.zhou@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
References: <20230724122101.2903318-1-alexander.stein@ew.tq-group.com>
 <20230724122101.2903318-3-alexander.stein@ew.tq-group.com>
 <20230724-unscrew-bonnet-3c86da806df3@spud> <1908243.taCxCBeP46@steina-w>
 <20230726170141.GA1568248-robh@kernel.org>
 <AS4PR04MB9244D1BD535A188356683DD58F12A@AS4PR04MB9244.eurprd04.prod.outlook.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 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
In-Reply-To: <AS4PR04MB9244D1BD535A188356683DD58F12A@AS4PR04MB9244.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Rob, Conor,

On 09/08/2023 22:43, Mirela Rabulea wrote:
>> -----Original Message-----
>> From: Rob Herring <robh@kernel.org>
>> Sent: Wednesday, July 26, 2023 8:02 PM
>> To: Alexander Stein <alexander.stein@ew.tq-group.com>
>> Cc: Conor Dooley <conor@kernel.org>; Mirela Rabulea
>> <mirela.rabulea@nxp.com>; Ming Qian <ming.qian@nxp.com>; Shijie Qin
>> <shijie.qin@nxp.com>; Eagle Zhou <eagle.zhou@nxp.com>; Mauro Carvalho
>> Chehab <mchehab@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
>> Shawn Guo <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
>> Fabio Estevam <festevam@gmail.com>; Mark Brown <broonie@kernel.org>;
>> Anson Huang <Anson.Huang@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
>> Pengutronix Kernel Team <kernel@pengutronix.de>; linux-
>> media@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; linux-spi@vger.kernel.org
>> Subject: [EXT] Re: [PATCH v2 3/3] dt-bindings: media: imx-jpeg: Add clocks
>> property
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report this
>> email' button
>>
>>
>> On Tue, Jul 25, 2023 at 07:31:55AM +0200, Alexander Stein wrote:
>>> Am Montag, 24. Juli 2023, 20:26:15 CEST schrieb Conor Dooley:
>>>> On Mon, Jul 24, 2023 at 02:21:00PM +0200, Alexander Stein wrote:
>>>>> i.MX8 and i.MX8X both use two clocks for accessing the periphery.
>>>>> Add clocks and clock-names properties accordingly.
>>>>>
>>>>> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Is this patch OK or do you want changes?

It's a bit unclear.

Regards,

	Hans

>>>>> ---
>>>>> Changes in v2:
>>>>> * None
>>>>>
>>>>>  .../devicetree/bindings/media/nxp,imx8-jpeg.yaml          | 8 ++++++++
>>>>>  1 file changed, 8 insertions(+)
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>>>>> b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml index
>>>>> 3d9d1db37040..2533e16720f2 100644
>>>>> --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>>>>> +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>>>>>
>>>>> @@ -46,6 +46,14 @@ properties:
>>>>>      minItems: 2               # Wrapper and 1 slot
>>>>>      maxItems: 5               # Wrapper and 4 slots
>>>>>
>>>>> +  clocks:
>>>>> +    maxItems: 2
>>>>> +
>>>>> +  clock-names:
>>>>> +    items:
>>>>> +      - const: per
>>>>> +      - const: ipg
>>>>
>>>> What do "per" and "ipg" mean? I assume "per" is peripheral?
>>>
>>> Actually I don't know what "ipg" stands for. It's a quite common name
>>> on i.MX platforms though. I opted for the names currently used in the
>>> DT. The driver doesn't care for the names currently.
> 
> Hi,
> Sorry for the late response.
> Yes, the driver uses now the clk_bulk functions, so it does not care for the names anymore (in the past it used the per/ipg names to get the clocks).
> 
>>
>> Those names date back about 25 years to Motorola Mcore GSM SoCs. IPG came
>> from IPG bus which IIRC stood for IP gasket. Essentially the bus was something
>> like Arm APB being slave only. The IPG clock is essentially the bus and register
>> access clock. 'per' is the functional clock in cases that need a defined clock rate
>> such as UART baud clock.
>>
>> There is also a shared (between CPU and DSP) bus called SPBA from the same
>> time which still lives on even though it isn't shared in i.MX chips.
> 
> Unfortunately, I cannot provide an explanation for the IPG acronym, I asked around, will come back if I get an answer.
> 
>>
>>> But cross-checking the reference manual these clocks seems to be called
>> "jpeg"
>>> and "ips", individually for both jpeg encoder and decoder.
>>
>> Given this block is probably licensed IP, seems like it would use something
>> different and be directly connected to AHB or AXI.
> 
> Yes, the Cast JPEG Decoder/Encoder is a licensed core, and it there is also an NXP JPEG Decoder/Encoder Wrapper, which provides the interface for the Cast JPEG Decoder/Encoder. The wrapper also provides AXI DMA engines for fetching Jpeg bitstream from memory and feed it to the Cast Jpeg or for storing the decoded pixel data into system memory through AXI bus. The wrapper also provides APB interface for wrapper and Cast Jpeg register access.
> 
> From our hardware team, I got the information that: for jpeg wrapper, it has two clocks(axi and apb), for CAST IP it has one clock(axi, whose clock source is same with wrapper on chip).
> 
>>
>>> Mirela (added to recipients): As the original author of the DT nodes,
>>> could you provide additional information regarding the clock names?
> 
> I understand that "ipg" usually is IP bus clk for register access, but I am not sure. Experimentally, I was not able to get register access unless both clocks were enabled. I'll get back if I get more details.
> 
> Regards,
> Mirela
> 
>>>
>>> Best regards,
>>> Alexander

