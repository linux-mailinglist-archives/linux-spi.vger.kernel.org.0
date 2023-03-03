Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27B36AA569
	for <lists+linux-spi@lfdr.de>; Sat,  4 Mar 2023 00:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjCCXKH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 3 Mar 2023 18:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjCCXKH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 3 Mar 2023 18:10:07 -0500
Received: from smtpout2.mo529.mail-out.ovh.net (smtpout2.mo529.mail-out.ovh.net [79.137.123.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D345EF9B
        for <linux-spi@vger.kernel.org>; Fri,  3 Mar 2023 15:10:05 -0800 (PST)
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.188])
        by mo529.mail-out.ovh.net (Postfix) with ESMTPS id E32522147F;
        Fri,  3 Mar 2023 21:52:42 +0000 (UTC)
Received: from kaod.org (37.59.142.95) by DAG4EX2.mxp5.local (172.16.2.32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 3 Mar
 2023 22:52:41 +0100
Authentication-Results: garm.ovh; auth=pass (GARM-95G001d732c472-8cab-4b6b-bb7d-bfc5848c7217,
                    D247C90D5DACFD620130D6A3F59DE8A1FE9C6D23) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 86.250.25.177
Message-ID: <6a1826c6-3951-03eb-d38c-56e7517c3c6e@kaod.org>
Date:   Fri, 3 Mar 2023 22:52:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/87] spi: aspeed-smc: Convert to platform remove
 callback returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        Mark Brown <broonie@kernel.org>, Joel Stanley <joel@jms.id.au>
CC:     Andrew Jeffery <andrew@aj.id.au>, <linux-aspeed@lists.ozlabs.org>,
        <openbmc@lists.ozlabs.org>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@pengutronix.de>
References: <20230303172041.2103336-1-u.kleine-koenig@pengutronix.de>
 <20230303172041.2103336-4-u.kleine-koenig@pengutronix.de>
From:   =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230303172041.2103336-4-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG4EX2.mxp5.local
 (172.16.2.32)
X-Ovh-Tracer-GUID: 827e19ec-485e-4362-bb35-131486e0838d
X-Ovh-Tracer-Id: 7794042108611103666
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrudelledgudegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepffdufeeliedujeeffffhjeffiefghffhhfdvkeeijeehledvueffhfejtdehgeegnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrdelheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegtlhhgsehkrghougdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepuhdrkhhlvghinhgvqdhkohgvnhhighesphgvnhhguhhtrhhonhhigidruggvpdgthhhinhdqthhinhhgpghkuhhosegrshhpvggvughtvggthhdrtghomhdpsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhjohgvlhesjhhmshdrihgurdgruhdprghnughrvgifsegrjhdrihgurdgruhdplhhinhhugidqrghsphgvvggusehlihhsthhsrdhoiihlrggsshdrohhrghdpohhpvghnsghmtgeslhhishhtshdrohiilhgrsghsrdhorhhgpdhlihhnuhigqdhsphhisehvghgvrhdrkh
 gvrhhnvghlrdhorhhgpdhlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdpkhgvrhhnvghlsehpvghnghhuthhrohhnihigrdguvgdpoffvtefjohhsthepmhhohedvledpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 3/3/23 18:19, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>   drivers/spi/spi-aspeed-smc.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
> index 873ff2cf72c9..3f2548860317 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -787,13 +787,12 @@ static int aspeed_spi_probe(struct platform_device *pdev)
>   	return ret;
>   }
>   
> -static int aspeed_spi_remove(struct platform_device *pdev)
> +static void aspeed_spi_remove(struct platform_device *pdev)
>   {
>   	struct aspeed_spi *aspi = platform_get_drvdata(pdev);
>   
>   	aspeed_spi_enable(aspi, false);
>   	clk_disable_unprepare(aspi->clk);
> -	return 0;
>   }
>   
>   /*
> @@ -1201,7 +1200,7 @@ MODULE_DEVICE_TABLE(of, aspeed_spi_matches);
>   
>   static struct platform_driver aspeed_spi_driver = {
>   	.probe			= aspeed_spi_probe,
> -	.remove			= aspeed_spi_remove,
> +	.remove_new		= aspeed_spi_remove,
>   	.driver	= {
>   		.name		= DEVICE_NAME,
>   		.of_match_table = aspeed_spi_matches,

