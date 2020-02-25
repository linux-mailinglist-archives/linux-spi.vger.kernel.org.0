Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59F7716BB5E
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2020 08:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgBYH4g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 25 Feb 2020 02:56:36 -0500
Received: from mail-mw2nam12on2069.outbound.protection.outlook.com ([40.107.244.69]:9505
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729065AbgBYH4g (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 25 Feb 2020 02:56:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZMDn0bgmxAK4IzKRwOvdB8jzFNQaTNdCxoPIkGMnJA7uCboZV3KGSi1Oc5CIXmayhNNAeO9AzH0mY8jj4ybRv7oPPmWne/lzCeibI7CmpHFRtACpXkYMbZwWvDGuS/o05i3Y69XiuX/pf3bP7HPWLd/oqPicXvE+KUoOopI9hIJk76yCXeT9sngiBGnDmxV0WzqZA6O1Fi0IB9YVzQJT7p7JWqZNScKrfmK/fY853ULodoBX/K6R8egiKXkX9Wx539VRfnbKIf4F5pQFBtNtiymedLkgMwyM9g5Ap2x8MnZfIygc0FQoB9Z2xI4Q6b1oeHsJc4PODOvcUTgCCgZqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hBoBTh/5Ex/Qx85Xj2py8+sSuNp75X1TF4ineXm2tM=;
 b=edeqzw5la5LXSQCaKbK3bKDeUVZ1GNxvIsmjcvwiHHXYpzfpwWRfCieDhwMv8WUpO3UCyZl6Dwcv80MrjouxYf5ZbZRgGwTRS9f/4/qBKl1Sly29Gsvfxp1Sv/sAE+tWTWH/dtChR9FjVzpGTTiPaQAwogKGx0shXmXDv548qkKvzcdrm0nOGsd+oB/zrzE2vEVstA6IaqeY6CMZwvYLho1FOyNS9AeHtg4dgptad5UfZVggIPUL2J/xFk7kxwkrmeeXaqGSL+OWwMAbMC0sDtVqlNj4R2/gXZMv5Kvem/ywVJNHmEDdQxXOnkAG99hB/8yPqvdM8ZfsCDmAKVpo/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hBoBTh/5Ex/Qx85Xj2py8+sSuNp75X1TF4ineXm2tM=;
 b=qmJDTyot2QUvkZU+i2XCmbwJ9tJwreWPYuN0STR/NFvMxMZ3gL/fSmFuwfbOC64tRPH1FTg0qAsSCaVH1hLFDWsVTRgNzQS7hbTfs+XHLs7By5bOLRgR2lKVyj6koLe59OUuYsvf8QVEUQV3bK97W61Yo0QV6qhkHiWSeFvZ9ME=
Received: from CY4PR06CA0026.namprd06.prod.outlook.com (2603:10b6:903:77::12)
 by SN6PR02MB5439.namprd02.prod.outlook.com (2603:10b6:805:e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 07:56:32 +0000
Received: from CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:77:cafe::d6) by CY4PR06CA0026.outlook.office365.com
 (2603:10b6:903:77::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Tue, 25 Feb 2020 07:56:32 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT064.mail.protection.outlook.com (10.152.74.64) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2750.19
 via Frontend Transport; Tue, 25 Feb 2020 07:56:32 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j6V4x-0001SH-J2; Mon, 24 Feb 2020 23:56:31 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1j6V4s-00052G-GE; Mon, 24 Feb 2020 23:56:26 -0800
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 01P7uOrg028738;
        Mon, 24 Feb 2020 23:56:24 -0800
Received: from [172.30.17.108]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1j6V4p-000529-Tr; Mon, 24 Feb 2020 23:56:24 -0800
Subject: Re: [PATCH] spi/zynqmp: remove entry that causes a cs glitch
To:     Thommy Jakobsson <thommyj@gmail.com>, broonie@kernel.org,
        michal.simek@xilinx.com, linux-spi@vger.kernel.org,
        naga sureshkumar relli <naga.sureshkumar.relli@xilinx.com>
References: <20200224162643.29102-1-thommyj@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <b705ab09-b4ce-29f2-448f-cca5556f848c@xilinx.com>
Date:   Tue, 25 Feb 2020 08:56:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224162643.29102-1-thommyj@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(39860400002)(376002)(189003)(199004)(356004)(316002)(2616005)(44832011)(5660300002)(70586007)(26005)(186003)(6636002)(8936002)(426003)(9786002)(36756003)(478600001)(31696002)(336012)(2906002)(110136005)(8676002)(70206006)(31686004)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5439;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ff0956f-d4d8-4868-2eb5-08d7b9c83a77
X-MS-TrafficTypeDiagnostic: SN6PR02MB5439:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5439476F46EF31B5D57D7FD3C6ED0@SN6PR02MB5439.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0324C2C0E2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wC/kPIHUAE3jQ6YoqaVAEtk46bGi+BFb4RtjIMjD/RiuecHFvB/G0iIcd03vWwbKP33SV+E5QNcKY7mAop2yruaZ1+eb3VvwZKP92cgD6N1kh+XvZmnJVMSYeu+y0etyQ1BXMiWuSckFBqvnqPQEkQ0dtXORB07krYL5UNey8ZYQscg3jf3+Sh7Yv832sF01Stmo9jo6w1gWNapuUa5Ys+ffl7oWOJ0nf559pL9ghLigGudeRN19Nady4wBxly3T+HxU0XpXo0cXEwLAxJtgqDSqcU5i7Da0CVuf4CRDaaALfECtD7xmkugFlaSjSUdJcahPWtPqtulnipEwUER9v+hvQwN6ikmHh6xoA03yuFvak2zdprMzX56WFSzY0Ysc0df4/mZAOz/g3trKKyhKH8qlRX7Om/BdhvBBm7Rgl5OTrzDO8wgTKiG03uH5bOp
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 07:56:32.0410
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ff0956f-d4d8-4868-2eb5-08d7b9c83a77
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5439
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 24. 02. 20 17:26, Thommy Jakobsson wrote:
> In the public interface for chipselect, there is always an entry
> commented as "Dummy generic FIFO entry" pushed down to the fifo right
> after the activate/deactivate command. The dummy entry is 0x0,
> irregardless if the intention was to activate or deactive the cs. This
> causes the cs line to glitch rather than beeing activated in the case
> when there was an activate command.
> 
> This has been observed on oscilloscope, and have caused problems for at
> least one specific flash device type connected to the qspi port. After
> the change the glitch is gone and cs goes active when intended.
> 
> The reason why this worked before (except for the glitch) was because
> when sending the actual data, the CS bits are once again set. Since
> most flashes uses mode 0, there is always a half clk period anyway for
> cs to clk active setup time. If someone would rely on timing from a
> chip_select call to a transfer_one, it would fail though.
> 
> It is unknown why the dummy entry was there in the first place, git log
> seems to be of no help in this case. The reference manual gives no
> indication of the necessity of this. In fact the lower 8 bits are a
> setup (or hold in case of deactivate) time expressed in cycles. So this
> should not be needed to fulfill any setup/hold timings.
> 
> Signed-off-by: Thommy Jakobsson <thommyj@gmail.com>
> ---
>  drivers/spi/spi-zynqmp-gqspi.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index 60c4de4e4485..7412a3042a8d 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -401,9 +401,6 @@ static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high)
>  
>  	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry);
>  
> -	/* Dummy generic FIFO entry */
> -	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0x0);
> -
>  	/* Manually start the generic FIFO command */
>  	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
>  			zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
> 

Naga: Can you please review this?

Thanks,
Michal
