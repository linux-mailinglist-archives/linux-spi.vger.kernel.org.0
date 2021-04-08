Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608D93580AB
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhDHKf1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 06:35:27 -0400
Received: from mail-bn8nam12on2087.outbound.protection.outlook.com ([40.107.237.87]:31013
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229517AbhDHKf1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 06:35:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3l5xlCQW9BUuWoF8N3+Zciw8TaT58rIeIpIncUXntRl7rHNsjOgiIT7YF3LOS9fKRBtn0MtvQzOmst5KFYRHcrtErcDYokRRE/yUsWkyF7t/bwcgAn2OLI8XXEyV9AO3c1dz+Gxo3VHYUKx4TDxdVhbsq3oVm1kTJv+4e3k1rA4WLj1zXubOusj74mSyB+IDVLZPPVtIUcyQyk7yPg8YPuirTGPnxEwc7HWfmA99JJPEb38qNJPuZx1tB6YGKHIX2k4VrjUAQEHB6aqCyQw3eCIvLdG5wZFC9EHBtZljVHW8zBSzY28q68wAmKDeWnb1e6vgZQY791n2BIx1yH8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKTvmQrQ0WQUIiGxLpMHlstk/ZWh9q6bsmsFhO2MCUo=;
 b=StpkRKX3ymCh5nR00pTuK1d/gZFEk6vI4HQ0i2iTFCjijzJYajj/CPWrTRpd44XBgzV4LhZkh6a/iFQndtPq4zQ6Xh4lA/8ygzgLXBnknwxYXEiWLz05zl/vAclTqXtqQ0EjQtQnS/sP3rxp5nMvFq9ARFeLMBycI6bgwhBtRaNcOjTpOU6WIjOIhhzTB4Wp9okVSCjiNzH9wF03OW+jHysVGd2yPLgQc2LTPcmAqFQlYAjJa2SlZUx9hyRCCbgtU0hhq6YUEC59EaZKwZxP2eDtEfpgFaEkTPiMOMu24tVOmOkep4gSqSFYIiFNNOpbDUwYTOLAZQF8/CjhnL3FcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKTvmQrQ0WQUIiGxLpMHlstk/ZWh9q6bsmsFhO2MCUo=;
 b=bWYb+CC1411njnKBtn1enTMpaMK15xlnmN5FuhE3a95gw1akkKLhIH1mUw0Lsl8jxCTry6uPfsEApdha8mLJ9Y8RliKcDYbRsY5UTPXiq9f9OfFyvGALnq4UewlVkmOthhxg8BgPkq6L6TGtsLCVT2GxBmvo4+j33ixJGGlcvg8=
Received: from DM5PR05CA0007.namprd05.prod.outlook.com (2603:10b6:3:d4::17) by
 DM6PR02MB6683.namprd02.prod.outlook.com (2603:10b6:5:218::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.27; Thu, 8 Apr 2021 10:35:13 +0000
Received: from DM3NAM02FT042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::69) by DM5PR05CA0007.outlook.office365.com
 (2603:10b6:3:d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.9 via Frontend
 Transport; Thu, 8 Apr 2021 10:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT042.mail.protection.outlook.com (10.13.4.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 10:35:12 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 03:35:08 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Thu, 8 Apr 2021 03:35:08 -0700
Envelope-to: linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org,
 broonie@kernel.org,
 quanyang.wang@windriver.com,
 kjlu@umn.edu,
 dinghao.liu@zju.edu.cn
Received: from [172.30.17.109] (port=36494)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lURyz-00087D-7Z; Thu, 08 Apr 2021 03:33:53 -0700
Subject: Re: [PATCH] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in
 zynqmp_qspi_probe
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, <kjlu@umn.edu>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Quanyang Wang <quanyang.wang@windriver.com>
CC:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210408092559.3824-1-dinghao.liu@zju.edu.cn>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <17b5d33f-ce96-dc07-05f7-41d87f53a3d0@xilinx.com>
Date:   Thu, 8 Apr 2021 12:33:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210408092559.3824-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7567318-b8b6-4354-60ff-08d8fa79fdc8
X-MS-TrafficTypeDiagnostic: DM6PR02MB6683:
X-Microsoft-Antispam-PRVS: <DM6PR02MB66833533E88011DF93E99FADC6749@DM6PR02MB6683.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QukD+WT5aCTrHWt4L57R69luHpcBYVwATvqtwhufB3x//YDgKrY4quLFPiPZLSpc4jvXg4jxuSdo7tmQaZbMI5Ff4/OSWITj5ft1h7X1d8S5tnIyr91i6HxRMOl1QAd5VjujYEhF8VJ/BPzf2e9wWyDdDIY8Qn8RNJoNjxZERRlz4Rs2Mln9++kVbAtCk+WLbwsnsr4mrRwiV81+/2XfHR+urXMQ9k0T6vK6L1h7c/NGBP5HpW4NoNHJdrFG9KSlVXRiRAQpRucQmPHHZQwHIeydbJg5rx7DUIm/3jTIZ2wm/7RcVYJ35w/YuZ6VqJ5IT/BtjgAkNJuFGd0gxTVkMYKi8jtWufs5eM4HDS5hLLFwmR5gx7tsBNe7yLXz9X0ymR1Do0iGkwYYbLva6WGv5c19euqw1HM4x0Bzf9CiKUjyts04tciJnV3GafodiTk/0Eod9cvgILRMeEYryhsOb+CDdqExL/K/xORN/9ZIln41cNmGf9UIUmbU/hmp3QK9Hpp7pxAZySNySNKn9uBhjgiOjOZTEpTrTOLgacfd4yN32gPzUg4j5gtOue5oGXrSmiPSTiO/iYdl0yI/y7c19dpmvNoudt7C+eiKBQxykUE1/PWTQY05gT9l9GUrjisFEbg6FlXKeSIL2+Ob4ApgPJs6EAE0aJACmipgDzY9nPSaMbEHlgoIjSgrRQgoTJUQ89JjHqWtnB4s+ZrRy1iWHQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(376002)(39860400002)(136003)(346002)(36840700001)(46966006)(83380400001)(7636003)(82740400003)(70586007)(36860700001)(53546011)(336012)(36906005)(44832011)(6666004)(36756003)(8676002)(478600001)(9786002)(4326008)(54906003)(31696002)(70206006)(4744005)(26005)(426003)(356005)(8936002)(2616005)(186003)(47076005)(316002)(5660300002)(82310400003)(31686004)(110136005)(2906002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 10:35:12.7790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7567318-b8b6-4354-60ff-08d8fa79fdc8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6683
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

++

On 4/8/21 11:25 AM, Dinghao Liu wrote:
> When platform_get_irq() fails, a pairing PM usage counter
> increment is needed to keep the counter balanced. It's the
> same for the following error paths.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/spi/spi-zynqmp-gqspi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index c8fa6ee18ae7..95963a2de64a 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -1197,6 +1197,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
>  	return 0;
>  
>  clk_dis_all:
> +	pm_runtime_get_noresume(&pdev->dev);
>  	pm_runtime_set_suspended(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	clk_disable_unprepare(xqspi->refclk);
> 
