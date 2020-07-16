Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40A2221D34
	for <lists+linux-spi@lfdr.de>; Thu, 16 Jul 2020 09:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgGPHVB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 Jul 2020 03:21:01 -0400
Received: from mail-dm6nam10on2059.outbound.protection.outlook.com ([40.107.93.59]:47072
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726069AbgGPHVB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 16 Jul 2020 03:21:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3e6YnJGxZkm0VuuE4mrY2W8u2e72gVYHg1GXHpEWKie4KuMnCxwr/AEesaITiYZIH/tBRLRPR1MAGmof+MO/JfhgpQmuul2gvK7oEp7hxNh8hudwSVBZj7+K9BxIlerc39nxUtyYQYczCjTH/09UFsNbpzQGxuu620ZHF1KitAcoam6McjBcEyo2PPyFc9qrYFer3+Oub77mhfIitOeSWp+vQXMD75Krag7iZwUuSdT75GWHb69UL8+phCh5393ItvAJq0WKWl5caJ5xjuD3p+xa+dYywfb87CC2BLD1XzTYOZHWPzqAn+dLP9q0HXZqJMUj/oBiNjbtZZJx0Cb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSm3Bs4GtjL3mWNZYTAGcOTn/A0FQohcotZnd2+iUc4=;
 b=obgiXWgRShO2DftUG+E1lD0lRFVAMi8aKsWmaSEK42q+3iSOnd1g6IY+qt9KFQY5DShHdfrx9tRsvO76opHBq4vUdlz4FCIMFrIxn5JItwGiHrqKYTL1Yia323fr1DFE0T5oJVgujsB9AjrqyTKBasZxqSjGlcBrX7Oo5FSXuptd/iyUxeXIWSXw2c3rrORPvhb/76YbwYxDR61uvH74zgLEUZo5KA3Gzgd4SKA1HeP9RM7boMa+nsf9YoLjZSYwNJ/hX8Azx6ms6mT1z2PaIMR2Y3WeqVlfu+UxWNwMRQz0GnKD1rTwDud2hxHCUtzUgFgFobwYyOY3i2uwCTTtaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=linaro.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSm3Bs4GtjL3mWNZYTAGcOTn/A0FQohcotZnd2+iUc4=;
 b=Y1ahO9to10Nrs/9LgYYwL3x6KeXJFSO8tAbeiXWjHEeskUfsAHfLH9YraaSvMtqZn0+Zgi3Nl4aiIs4z65tiCL7NF7BLwKTznRw9eKEvRxyMCKHGXxIN+NtVece30NH0Byp6lQjM6lWVNV5+xNOTHPieIce53r025Uyfig2ONHc=
Received: from MN2PR20CA0012.namprd20.prod.outlook.com (2603:10b6:208:e8::25)
 by DM6PR02MB6315.namprd02.prod.outlook.com (2603:10b6:5:1f7::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 07:20:57 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:e8:cafe::29) by MN2PR20CA0012.outlook.office365.com
 (2603:10b6:208:e8::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Thu, 16 Jul 2020 07:20:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server id 15.20.3195.18 via Frontend Transport; Thu, 16 Jul 2020 07:20:57
 +0000
Received: from [149.199.38.66] (port=57278 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jvyAj-00018n-5N; Thu, 16 Jul 2020 00:19:13 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1jvyCO-0007ed-UD; Thu, 16 Jul 2020 00:20:56 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 06G7KjTE004534;
        Thu, 16 Jul 2020 00:20:45 -0700
Received: from [172.30.17.109]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1jvyCC-0007XJ-La; Thu, 16 Jul 2020 00:20:45 -0700
Subject: Re: [PATCH 10/14] spi: spi-zynqmp-gqspi: Correct a couple of
 misspellings in kerneldoc
To:     Lee Jones <lee.jones@linaro.org>, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>
References: <20200715150632.409077-1-lee.jones@linaro.org>
 <20200715150632.409077-11-lee.jones@linaro.org>
From:   Michal Simek <michal.simek@xilinx.com>
Autocrypt: addr=michals@xilinx.com; keydata=
 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
 0Z1MQlmNcq2bhOMzTxuXX2NDzUZs4aqEyZQ=
Message-ID: <74e6a09e-cbef-b727-aab9-e6c020a7dd6c@xilinx.com>
Date:   Thu, 16 Jul 2020 09:20:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715150632.409077-11-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(376002)(346002)(39860400002)(396003)(136003)(46966005)(478600001)(36756003)(426003)(2906002)(8936002)(336012)(5660300002)(107886003)(186003)(8676002)(4326008)(2616005)(356005)(47076004)(6666004)(81166007)(82310400002)(31686004)(316002)(83380400001)(9786002)(70206006)(31696002)(70586007)(26005)(82740400003)(44832011)(43740500002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27cdb15c-6234-4a42-fbf7-08d82958c8aa
X-MS-TrafficTypeDiagnostic: DM6PR02MB6315:
X-Microsoft-Antispam-PRVS: <DM6PR02MB63156C0F1AAAD96EE51F72FEC67F0@DM6PR02MB6315.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vLnHHiB0Tcp3F5JeMr1mIKYcsyzMCExlTDsaCRBgn3LPFDdJJ3nzw/mjvql7miG7f26f15CaFzSzei9hwuVs8z8ka4vyuOSiDZ+9SX0aZ4eqsZBUji8zQruGqlbpQTAGEyQ8ozla94is3I94IlSBi1Eztp2h4PRSG58i334ewoHit+eN3JFH08JmsYpJFOjp2SSprGDKPlcBbl40uLJ6G5dFfBadDrJY/WJ+hu+fDQ3SwzbI3wPnH1MYMJLmLMEKjwDbQgg1NbEkdx6BvJ7zXJv6FM8jDn3vYBs7sU87JnLscjYIxAPKxGcJZYPjzMrsXKWuLNgcz+H5HSlth7VoucwPdA9C4KEMCMejcZb+iwInWDnu0+kmTZkNRn8+zTHIomsX9ObJShRBnZU6bFETGYkU42QUYAgnYFi91XX2N+w5WecCVQKohiX2XWQf9sr4
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 07:20:57.3354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cdb15c-6234-4a42-fbf7-08d82958c8aa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6315
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 15. 07. 20 17:06, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/spi/spi-zynqmp-gqspi.c:205: warning: Function parameter or member 'slavecs' not described in 'zynqmp_gqspi_selectslave'
>  drivers/spi/spi-zynqmp-gqspi.c:205: warning: Function parameter or member 'slavebus' not described in 'zynqmp_gqspi_selectslave'
>  drivers/spi/spi-zynqmp-gqspi.c:205: warning: Excess function parameter 'flashcs' description in 'zynqmp_gqspi_selectslave'
>  drivers/spi/spi-zynqmp-gqspi.c:205: warning: Excess function parameter 'flashbus' description in 'zynqmp_gqspi_selectslave'
>  drivers/spi/spi-zynqmp-gqspi.c:902: warning: Function parameter or member 'dev' not described in 'zynqmp_qspi_suspend'
>  drivers/spi/spi-zynqmp-gqspi.c:902: warning: Excess function parameter '_dev' description in 'zynqmp_qspi_suspend'
> 
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/spi/spi-zynqmp-gqspi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index 811c97a7c8589..e17a201252557 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -197,8 +197,8 @@ static inline void zynqmp_gqspi_write(struct zynqmp_qspi *xqspi, u32 offset,
>  /**
>   * zynqmp_gqspi_selectslave:	For selection of slave device
>   * @instanceptr:	Pointer to the zynqmp_qspi structure
> - * @flashcs:	For chip select
> - * @flashbus:	To check which bus is selected- upper or lower
> + * @slavecs:	For chip select
> + * @slavebus:	To check which bus is selected- upper or lower
>   */
>  static void zynqmp_gqspi_selectslave(struct zynqmp_qspi *instanceptr,
>  				     u8 slavecs, u8 slavebus)
> @@ -892,7 +892,7 @@ static int zynqmp_qspi_start_transfer(struct spi_master *master,
>  
>  /**
>   * zynqmp_qspi_suspend:	Suspend method for the QSPI driver
> - * @_dev:	Address of the platform_device structure
> + * @dev:	Address of the platform_device structure
>   *
>   * This function stops the QSPI driver queue and disables the QSPI controller
>   *
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
