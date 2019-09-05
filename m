Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20BF7A99FA
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2019 07:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfIEFU2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Sep 2019 01:20:28 -0400
Received: from mail-eopbgr730089.outbound.protection.outlook.com ([40.107.73.89]:10231
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfIEFU2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Sep 2019 01:20:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QefvtaMsqxyUrhCCN0xHL4XRqqF5IW68q09mQ2W5xzJaDMy5VvZDz0GAeK+l2To+fXXRchNnzVjoqEL8kRzV8d56R7Myqh1p5/GsLd2zsHkk6OgFU6sSQ/nwig3kvA/E0sOmDn4ulspPw4eM9CKsknLWMe81X3+nw5pihCuDOoUGQgOAT0rQsQPBkudZDp9TO0zDhb5MwfXZVX7yqbigjvQ0fjCjeTu+tEecr/Hfwp8T03NkTZ27gvNmaoQoTy6njtx2SIwjlEhPCt0cokGzKJRcytqm0o7RRWgIEHpiI8I8s8NQ31iVrKxXR5YDaOYHvOyzMFK0f02ivtX/+Bt/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQAzwEfRXD7T3ZN4nz/9r0j5k1a9CTAdOWrL2FjF1zg=;
 b=nEbla+dd8ph4PrqbV6OpUR0EEapeHXBBFKPtrxz07OegHXLUz6Dw6BOLhtL0kCg7WbtP4/ASQraD3PEoWN0vsFb+CTZvPyioQtGUSufwyevOB6h1JotrMX8n/6wMq/OYCUowa30W9rcCtnEm2k5DLG8plHCwIy2uZqQf1WN/y8n2uhc0zoB/BYnOm/hfDvcJuNmi/ZjaNtDYkV2cmZx+JeuAbjj2sI2chozvXkanhl7c/Tp8SkbQCvJYruy4LLuOYHv6JHHca3kOZQ6OXZ3du35ISPBi1oPdA/bTz8lXlNBxbhZo/jGptqco4dFmMmjaCFp/+K1Z0XLhKDAJ64j7jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=huawei.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQAzwEfRXD7T3ZN4nz/9r0j5k1a9CTAdOWrL2FjF1zg=;
 b=b20+yIaTHL+sWa1MmF3rael+2EEg/cLklBViLAteI0dvNbSmHu7Toa1UcpCt+tXqkSafKgdSu8AeAGHqg/rWdLfOurObnI0vfNCeVwWMY/AzRtcsDeNmgbohg0qID7UMeP4GUjYBk6WasnRBtrgcUydOV3vIsKBZTjWyXjNMQIE=
Received: from BYAPR02CA0061.namprd02.prod.outlook.com (2603:10b6:a03:54::38)
 by BN7PR02MB5316.namprd02.prod.outlook.com (2603:10b6:408:2b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2178.16; Thu, 5 Sep
 2019 05:20:23 +0000
Received: from CY1NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::201) by BYAPR02CA0061.outlook.office365.com
 (2603:10b6:a03:54::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.15 via Frontend
 Transport; Thu, 5 Sep 2019 05:20:23 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT056.mail.protection.outlook.com (10.152.74.160) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Thu, 5 Sep 2019 05:20:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:37867 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i5kBw-0001s1-5D; Wed, 04 Sep 2019 22:20:20 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i5kBr-0006dk-00; Wed, 04 Sep 2019 22:20:15 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x855K7PS002245;
        Wed, 4 Sep 2019 22:20:08 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1i5kBi-0005k1-Ga; Wed, 04 Sep 2019 22:20:06 -0700
Subject: Re: [PATCH -next 35/36] spi: zynq-qspi: use
 devm_platform_ioremap_resource() to simplify code
To:     YueHaibing <yuehaibing@huawei.com>, broonie@kernel.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        eric@anholt.net, wahrenst@gmx.net, shc_work@mail.ru,
        agross@kernel.org, khilman@baylibre.com, matthias.bgg@gmail.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, kgene@kernel.org,
        krzk@kernel.org, andi@etezian.org, palmer@sifive.com,
        paul.walmsley@sifive.com, baohua@kernel.org, mripard@kernel.org,
        wens@csie.org, ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, yamada.masahiro@socionext.com,
        michal.simek@xilinx.com
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-samsung-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-tegra@vger.kernel.org
References: <20190904135918.25352-1-yuehaibing@huawei.com>
 <20190904135918.25352-36-yuehaibing@huawei.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <fbd385ec-f24d-7628-5f63-03f4444976aa@xilinx.com>
Date:   Thu, 5 Sep 2019 07:19:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904135918.25352-36-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(4636009)(346002)(396003)(136003)(376002)(39860400002)(2980300002)(189003)(199004)(478600001)(58126008)(316002)(106002)(52146003)(2486003)(6246003)(76176011)(23676004)(4326008)(5660300002)(65956001)(65806001)(47776003)(6666004)(356004)(70586007)(70206006)(36756003)(44832011)(26005)(2616005)(305945005)(186003)(11346002)(446003)(2906002)(476003)(7416002)(7406005)(336012)(426003)(126002)(36386004)(50466002)(230700001)(31696002)(8936002)(31686004)(486006)(81166006)(81156014)(8676002)(229853002)(9786002)(921003)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5316;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2770641f-c6d9-49ae-fa79-08d731c0c0b0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BN7PR02MB5316;
X-MS-TrafficTypeDiagnostic: BN7PR02MB5316:
X-Microsoft-Antispam-PRVS: <BN7PR02MB531625F4F25A281A255B5CD4C6BB0@BN7PR02MB5316.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 015114592F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: qv/pAS4OAoGo44rOeZ2Hm2SpuPSdh5pU2/ZuTflAnnakUZOlssAhfQ6teplQXOgiqD8dzoUW3NUgI4G/HIFXIZpXXHH4GNpyVofLYAQDiEYD6fVPXJ5RMt6fQBmW7TyiKV2zcwDwByMjhh3akRMWo6Ps0V8EhBeuj2Afa4Ht/srGaNbvcwr41sjRTh+qq45a/Im6ul1rf/Fv7VnFyBX1BM7VQFJ2Mj1d7PUxxxLB83CpHvVhNpTeCHtHxz+ovsB9PvxxaZ3Y2/jvyDvT9aD+JFjVlD5JRuvFwBqGaYleSzAj67tU0HXgLzbQ5UteTcLIOxt27HNX+HDsE++ZAfbOSwBXIKG2IFw9GLPBqbytHVG+Y4B1svSjlCkuw3jLb6tNnA3mBBYehhsZtFa84mFH7Dm89fjPpfKoIC71tppkQRo=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2019 05:20:20.8182
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2770641f-c6d9-49ae-fa79-08d731c0c0b0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5316
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 04. 09. 19 15:59, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/spi/spi-zynq-qspi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
> index 4a5326c..5cf6993 100644
> --- a/drivers/spi/spi-zynq-qspi.c
> +++ b/drivers/spi/spi-zynq-qspi.c
> @@ -620,7 +620,6 @@ static int zynq_qspi_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct device_node *np = dev->of_node;
>  	struct zynq_qspi *xqspi;
> -	struct resource *res;
>  	u32 num_cs;
>  
>  	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
> @@ -630,8 +629,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
>  	xqspi = spi_controller_get_devdata(ctlr);
>  	xqspi->dev = dev;
>  	platform_set_drvdata(pdev, xqspi);
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	xqspi->regs = devm_ioremap_resource(&pdev->dev, res);
> +	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(xqspi->regs)) {
>  		ret = PTR_ERR(xqspi->regs);
>  		goto remove_master;
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
