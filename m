Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422EA3320EA
	for <lists+linux-spi@lfdr.de>; Tue,  9 Mar 2021 09:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCIImU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Mar 2021 03:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbhCIImJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Mar 2021 03:42:09 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60085C06174A;
        Tue,  9 Mar 2021 00:42:09 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Dvpbz4MBGz1ryp6;
        Tue,  9 Mar 2021 09:42:07 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Dvpbz1glSz1qqkd;
        Tue,  9 Mar 2021 09:42:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id f1TKAr_iO-dG; Tue,  9 Mar 2021 09:42:02 +0100 (CET)
X-Auth-Info: 5s+9mdwj1GaReZCA+LKM+vFVsZgjR99lUBERTNsM+a0=
Received: from [192.168.1.107] (92-52-238-184.pool.digikabel.hu [92.52.238.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue,  9 Mar 2021 09:42:02 +0100 (CET)
Reply-To: hs@denx.de
Subject: Re: [PATCH v2 0/4] enable flexspi support on imx8mp
To:     Marco Felsch <m.felsch@pengutronix.de>
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
        Shawn Guo <shawnguo@kernel.org>,
        Teresa Remmet <t.remmet@phytec.de>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
References: <20210309053116.1486347-1-hs@denx.de>
 <20210309081926.aer6dgum7nljoc57@pengutronix.de>
From:   Heiko Schocher <hs@denx.de>
Message-ID: <9a7812b6-e2fb-df00-833e-dff997105858@denx.de>
Date:   Tue, 9 Mar 2021 09:41:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210309081926.aer6dgum7nljoc57@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Marco,

On 09.03.21 09:19, Marco Felsch wrote:
> Hi Heiko,
> 
> On 21-03-09 06:31, Heiko Schocher wrote:
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
> 
> Thanks for picking up the comments :) Did you missed to send them or did
> you used an other Cc: and To: for the new patches?

Damn, I use patman tool from u-boot source whoch generates cc list
and missed to add you explicitely to Cc... sorry

They are all on linux-arm-kernel:

http://lists.infradead.org/pipermail/linux-arm-kernel/2021-March/643290.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2021-March/643291.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2021-March/643292.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2021-March/643293.html

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
