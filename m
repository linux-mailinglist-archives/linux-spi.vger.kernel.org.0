Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 178DAA9A00
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2019 07:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbfIEFUe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 5 Sep 2019 01:20:34 -0400
Received: from mail-eopbgr820077.outbound.protection.outlook.com ([40.107.82.77]:16128
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfIEFUe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Sep 2019 01:20:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WTPqT3NV40EAgHb4NRZ87arJG5IEyYxaVmJlozuJofzQu8KiKo4B13juahclxrwhRm562Y29pE5UCtm9oykjUh6R5HnNkXXGHDpEfFZd2yqViBDq5pSVuqj8fl8HVh3pZ8J2oSH4jYg+1asvST4HU/P8Pcs4v/Ts0ix/ilfu5l3TbDGH5WNv46yKGhEgc67vR38TeXAMGA8VDkaRwSe/ccno0zKcH8OltFlFZ5H8upLmf4LE2xBBfUBNbDAu5BIJb2qn5WFUtcncfzZFelEDvbCIU19loxA0GCL1g/7t2yvSc/x6iwQnf8GGQg0mhQ3hUTweUW30CNl+BnlZgcXycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWZiTF6LDxv801hBYWsUrl1FImWGGMnV9HI+PvZzS/E=;
 b=Ay3wPLSN1om3EURT1yNLfVC5gPo2RB+XNMzcVjG0GnIZ/sjHh0e30F084ZmFM8RO/u/fTqme2ERqEYs447tirRkLgPKtFdRCvOigsLgWrcmFme4GJ5wLY1dGQezFJdjGqr8PN7uTSQXi+7I0SAbrpKBZRq2k8nIcdLM4vn9+6ggmCV5P7h8aXBUZHvi6ujkM0e4AkqS3kbV1RKowvb4LDYp2LZC7nEtCps4pddxJ54dqDmpG6E0F7RbM1z8gcCA5Aa+MFFZ7Cb8siBrG5RzPkTCEESG7rTi98LuoL/eIpi7L/IxjyM3fU3KAvNtFYhbyemLE96R8g4qVmn9ci0wVig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.100) smtp.rcpttodomain=huawei.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWZiTF6LDxv801hBYWsUrl1FImWGGMnV9HI+PvZzS/E=;
 b=m4mJdT0dSpC3upWdAdPLvIjDRcKPg5t0fkKu5skSCiTU4/vudxWuVR+cJv60gHNvQ7VJ+qHbpkLonhH5OdfmmOOW/M5fOFwzrZjxdDw/Me3t/uOyQ3tFia0AWXhpY37HrzliJssZPdfK0ifo+bmvAEoDOyREQxvSl/NBZmqChPg=
Received: from MN2PR02CA0013.namprd02.prod.outlook.com (2603:10b6:208:fc::26)
 by BN7PR02MB5331.namprd02.prod.outlook.com (2603:10b6:408:2b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2199.21; Thu, 5 Sep
 2019 05:20:29 +0000
Received: from CY1NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by MN2PR02CA0013.outlook.office365.com
 (2603:10b6:208:fc::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2220.19 via Frontend
 Transport; Thu, 5 Sep 2019 05:20:28 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT031.mail.protection.outlook.com (10.152.75.180) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2241.14
 via Frontend Transport; Thu, 5 Sep 2019 05:20:11 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:34131 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i5kBm-0001qx-47; Wed, 04 Sep 2019 22:20:10 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1i5kBg-000601-KA; Wed, 04 Sep 2019 22:20:04 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x855JvMC001765;
        Wed, 4 Sep 2019 22:19:57 -0700
Received: from [172.30.17.116]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1i5kBZ-0005jH-CE; Wed, 04 Sep 2019 22:19:57 -0700
Subject: Re: [PATCH -next 34/36] spi: zynqmp: use
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
 <20190904135918.25352-35-yuehaibing@huawei.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <f267daf8-3351-a90a-35ea-94e1d8c20583@xilinx.com>
Date:   Thu, 5 Sep 2019 07:19:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904135918.25352-35-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(1496009)(136003)(39860400002)(376002)(346002)(396003)(2980300002)(189003)(199004)(2616005)(44832011)(336012)(11346002)(476003)(126002)(26005)(486006)(446003)(426003)(305945005)(6246003)(81156014)(229853002)(186003)(5660300002)(31696002)(7416002)(478600001)(2486003)(52146003)(23676004)(356004)(8676002)(6666004)(76176011)(4326008)(58126008)(316002)(106002)(50466002)(7406005)(2906002)(47776003)(70206006)(65806001)(36756003)(9786002)(65956001)(230700001)(70586007)(31686004)(81166006)(36386004)(8936002)(921003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR02MB5331;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fac73ab7-0bd2-4147-3dc1-08d731c0c371
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328);SRVR:BN7PR02MB5331;
X-MS-TrafficTypeDiagnostic: BN7PR02MB5331:
X-Microsoft-Antispam-PRVS: <BN7PR02MB53310A6D9FFB4A2590F44CA5C6BB0@BN7PR02MB5331.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-Forefront-PRVS: 015114592F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: xDHBjZQ8GYL4pdYhnRlKeinrYnOGSRK2gTz9Op8BpLU3YyfFpCkPVoShvRJKH9fqEOtwsdouUc2baNyy/393AFAy8yVDWUPlqhFvFzWhSzmgLOrpF77Vz7N3FlNYwHkZdHRbhbyk6STbg8Ip1oVAPOZtS6ebeSkRB551f/xUe90p0iOc4jRo3+bHyEc3sTDUObc3oTapGzxrgn7Nbw2VP9Y9MyT0A7XTROOWcNDeK/uAtZAwKuNDpw/VnbfVNhowlrnXsba+EIbDx39RbUaJ2Lp0Z8a2GjzfGzyjJSHGqP5m3T70AR5jgPiHh6cWWmBij1XrIsQRgiq1EcpvjeN1cLIoLctoM4DhNV9QhVesFQVyUDrZmtwXUnu1lND/fTr4l9DD3hz0IcIuRPnsRwkCTSTrmWpInqHshY8P1ZP9SEc=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2019 05:20:11.1281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fac73ab7-0bd2-4147-3dc1-08d731c0c371
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5331
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
>  drivers/spi/spi-zynqmp-gqspi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index 5e9ea8a..60c4de4 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -1016,7 +1016,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
>  	int ret = 0;
>  	struct spi_master *master;
>  	struct zynqmp_qspi *xqspi;
> -	struct resource *res;
>  	struct device *dev = &pdev->dev;
>  
>  	eemi_ops = zynqmp_pm_get_eemi_ops();
> @@ -1031,8 +1030,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
>  	master->dev.of_node = pdev->dev.of_node;
>  	platform_set_drvdata(pdev, master);
>  
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
