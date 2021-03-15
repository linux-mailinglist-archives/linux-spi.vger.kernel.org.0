Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248CF33AC0C
	for <lists+linux-spi@lfdr.de>; Mon, 15 Mar 2021 08:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhCOHLM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Mar 2021 03:11:12 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52287 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhCOHKy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Mar 2021 03:10:54 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4DzSHw1tckz1qs3c;
        Mon, 15 Mar 2021 08:10:52 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4DzSHv67yPz1qqkP;
        Mon, 15 Mar 2021 08:10:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Pda42FF0npmN; Mon, 15 Mar 2021 08:10:47 +0100 (CET)
X-Auth-Info: OHnDdbf9d0DEjw0wRgXAhlgaJLFD8ApsXDJzxnwTNiE=
Received: from [192.168.1.107] (82-131-155-123.pool.digikabel.hu [82.131.155.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 15 Mar 2021 08:10:47 +0100 (CET)
Reply-To: hs@denx.de
Subject: Re: [PATCH v2 0/4] enable flexspi support on imx8mp
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alice Guo <alice.guo@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Li Jun <jun.li@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Teresa Remmet <t.remmet@phytec.de>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20210309053116.1486347-1-hs@denx.de>
 <20210315064731.GL11246@dragon>
From:   Heiko Schocher <hs@denx.de>
Message-ID: <2c1e4c70-7616-85b3-bfa6-faf81dd72877@denx.de>
Date:   Mon, 15 Mar 2021 08:10:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315064731.GL11246@dragon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Shawn,

On 15.03.21 07:47, Shawn Guo wrote:
> On Tue, Mar 09, 2021 at 06:31:12AM +0100, Heiko Schocher wrote:
>>
>> This series enables support for the SPI NOR on the
>> imx8mp based phyboard-pollux-rdk board.
>>
>> Patches new in v2:
>> "spi: fspi: enable fspi driver for on imx8mp"
>> which adds own compatible entry for imx8mp
>>
>> and seperate in own patch the documentation entry in
>> patch "dt-bindings: spi: add compatible entry for imx8mp in FlexSPI controller"
>> as checkpatch says:
>>
>> warning: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst
>>
>>
>> Changes in v2:
>> - work in comments from Marco
>>   add own compatible entry for imx8mp
>> - work in comments from Marco
>>   - add own compatible entry "nxp,imx8mp-fspi"
>>   - reworked order of properties as Marco mentioned
>> - work in comments from Marco and Teresa
>>   - rename node into "'som_flash: flash@0 { }"
>>   - compatible is now first entry
>>   - removed #size-cells and #address-cells
>>     as no child node. If bootloader adds them bootloader
>>     can add them too.
>>
>> Heiko Schocher (4):
>>   spi: fspi: enable fspi driver for on imx8mp
>>   dt-bindings: spi: add compatible entry for imx8mp in FlexSPI
>>     controller
>>   arm64: dts: imx8mp: add flexspi node
>>   arm64: imx8mp: imx8mp-phycore-som enable spi nor
> 
> Two DTS patch look good.  Ping me when driver and bindings changes are
> accepted.

Thanks!

Hmm.. I have not splitted this series into 2 series... should I do
this now?

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
