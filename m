Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43105E7D4B
	for <lists+linux-spi@lfdr.de>; Fri, 23 Sep 2022 16:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbiIWOia (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 23 Sep 2022 10:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiIWOia (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 23 Sep 2022 10:38:30 -0400
X-Greylist: delayed 4203 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 23 Sep 2022 07:38:28 PDT
Received: from 5.mo548.mail-out.ovh.net (5.mo548.mail-out.ovh.net [188.165.49.213])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8E3140F21
        for <linux-spi@vger.kernel.org>; Fri, 23 Sep 2022 07:38:28 -0700 (PDT)
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.35])
        by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 73A5522912;
        Fri, 23 Sep 2022 09:51:44 +0000 (UTC)
Received: from kaod.org (37.59.142.103) by DAG4EX2.mxp5.local (172.16.2.32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Fri, 23 Sep
 2022 11:51:43 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-103G00568f9ec48-cedd-4175-94c7-41f1aa2872f7,
                    1A79B07E4615F001FB1D6782B56FC20B6E3AE419) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a51f9a8a-23aa-3795-3fce-963f2888b73c@kaod.org>
Date:   Fri, 23 Sep 2022 11:51:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH -next] spi: aspeed: Remove redundant dev_err call
Content-Language: en-US
To:     Shang XiaoJing <shangxiaojing@huawei.com>,
        <chin-ting_kuo@aspeedtech.com>, <broonie@kernel.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <openbmc@lists.ozlabs.org>,
        <linux-spi@vger.kernel.org>
References: <20220923101632.19170-1-shangxiaojing@huawei.com>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20220923101632.19170-1-shangxiaojing@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG4EX2.mxp5.local
 (172.16.2.32)
X-Ovh-Tracer-GUID: cdbb1851-2331-4364-814f-a2a0944c0b77
X-Ovh-Tracer-Id: 9344969228364450668
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeefiedgvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepieegvdffkeegfeetuddttddtveduiefhgeduffekiedtkeekteekhfffleevleelnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheegke
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 9/23/22 12:16, Shang XiaoJing wrote:
> devm_ioremap_resource() prints error message in itself. Remove the
> dev_err call to avoid redundant error message.
> 
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>   drivers/spi/spi-aspeed-smc.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 3e891bf22470..a334e89add86 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -736,10 +736,8 @@ static int aspeed_spi_probe(struct platform_device *pdev)
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	aspi->regs = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(aspi->regs)) {
> -		dev_err(dev, "missing AHB register window\n");
> +	if (IS_ERR(aspi->regs))
>   		return PTR_ERR(aspi->regs);
> -	}
>   
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>   	aspi->ahb_base = devm_ioremap_resource(dev, res);

