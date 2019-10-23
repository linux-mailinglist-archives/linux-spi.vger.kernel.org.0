Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 161EFE11BA
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2019 07:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfJWFiF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 23 Oct 2019 01:38:05 -0400
Received: from mail-eopbgr720054.outbound.protection.outlook.com ([40.107.72.54]:20832
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725775AbfJWFiE (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 23 Oct 2019 01:38:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrIpf0eOwPrTWF3N9GGCxpDWKGt0krmN6aAzPH666tfR5ucujiSR3LWnYZJ0RaFUaUddqaHrp8Gz+Juj86jSRfaYuOQ1PrY4W74j91TrIeaMvF0gP3mGTk4SR8f5+pKc8RRmsbK4sFFUoM3kSG3u3Eel+59PVany5MYwOQ+iVQioTS79zFnKdPF1EojJR0CvKYoD/o4pONCt//+OS4BzxQnMV+HCxMywo7gARoaNkkWyxHKanisN1KYQe1KQUP22/7VeW12aO4IJYJE5gkIw6qBV9EFfndMOR3gv0Eup5X/VTwNi+j/8ooJ6B6iTbO8dvQB3EtBgZdTLVqlMJmoxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ugb+mv00NAz3mHNiYFQNnHwrfih7CV3uyPD8ym+S484=;
 b=O1OEoOUYcpYSdgvrElmmvavAsJhUQESbH0TKndN8jv8y+aTLTn1ajFPcp4fuSEt0ypH/V7QqeyRRI3i2/ddGjnhFT+njLLMYzFNabmjPiCi+CtJai4CMPfhc+DK2YUrqAVALhQhSv+TX76uduYtqNWJV47jVRdtovVSKGEkqxaVolgUmix/iccis/ScjftVAfPVfAy+rpfgSdnEuZYdkrG/VUGpNfTX5QSYST4kDGxJBZyQu3RjnvEjaVm9X0/jP6+iHiNck6YhFiqtUln2ZC6OI9PMvluZAtcLTWaUNbmivq11E+sY7FXiC5TENjiMK2Tl144HLtSIL2/FoAWg7Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ugb+mv00NAz3mHNiYFQNnHwrfih7CV3uyPD8ym+S484=;
 b=d27WARLbA8JVgx6wIbsl3tgmU65e+Z32bN/921CbSHqgAf5dO7K5vxYvvXgs/teXco+TDyo8kiuR6UW65UkSpZNkFfpTusgBJ0s3/A5J/LqUwvJNBDB/nPjjxqGdVD24mmOyIlyWLqqXcvXkG5LdS16Wep1i03Qh3Sj6Jt9hzhA=
Received: from CH2PR02CA0021.namprd02.prod.outlook.com (2603:10b6:610:4e::31)
 by BY5PR02MB6657.namprd02.prod.outlook.com (2603:10b6:a03:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Wed, 23 Oct
 2019 05:37:49 +0000
Received: from CY1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by CH2PR02CA0021.outlook.office365.com
 (2603:10b6:610:4e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.21 via Frontend
 Transport; Wed, 23 Oct 2019 05:37:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT027.mail.protection.outlook.com (10.152.75.159) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Wed, 23 Oct 2019 05:37:48 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iN9L9-0001nH-RR; Tue, 22 Oct 2019 22:37:47 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1iN9L4-0007Am-O1; Tue, 22 Oct 2019 22:37:42 -0700
Received: from xsj-pvapsmtp01 (mailman.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9N5bYB7030794;
        Tue, 22 Oct 2019 22:37:34 -0700
Received: from [172.30.17.123]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1iN9Kv-00079c-Ss; Tue, 22 Oct 2019 22:37:34 -0700
Subject: Re: [PATCH] spi: xilinx: Add DT support for selecting transfer word
 width
To:     Mark Brown <broonie@kernel.org>,
        Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-spi@vger.kernel.org,
        Shubhrajyoti Datta <shubhraj@xilinx.com>
References: <20191022090007.15147-1-alvaro.gamez@hazent.com>
 <20191022102007.GA5554@sirena.co.uk>
 <20191022102859.GA1928@salem.gmr.ssr.upm.es>
 <20191022112600.GD5554@sirena.co.uk>
 <20191022120610.GA28659@salem.gmr.ssr.upm.es>
 <20191022152039.GH5554@sirena.co.uk>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <ecf7987f-be96-bf7c-f53d-ba79850bd5b0@xilinx.com>
Date:   Wed, 23 Oct 2019 07:37:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022152039.GH5554@sirena.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(4636009)(376002)(396003)(39850400004)(346002)(136003)(189003)(199004)(65956001)(47776003)(65806001)(305945005)(26005)(316002)(186003)(8936002)(31686004)(58126008)(54906003)(2906002)(36756003)(110136005)(6246003)(76176011)(4326008)(50466002)(107886003)(81166006)(106002)(81156014)(356004)(478600001)(476003)(8676002)(336012)(486006)(44832011)(5660300002)(31696002)(229853002)(126002)(23746002)(426003)(230700001)(9786002)(446003)(70586007)(70206006)(2616005)(11346002)(36386004)(6666004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR02MB6657;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4f444f4e-e564-4693-1378-08d7577b2399
X-MS-TrafficTypeDiagnostic: BY5PR02MB6657:
X-Microsoft-Antispam-PRVS: <BY5PR02MB6657E2C6AFF9D35DEF5E47B4C66B0@BY5PR02MB6657.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 019919A9E4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlUtALjXTP3WWiZ09JZpzgAVFp2OYDJYhcoxhIM6NSLi1nqWEcXRLOKpnslnirfNkxST4Ve7kpBH6gW8A0QOTcWZ/R7GCOEcX34tVwWz0OPioB88TkAzwWpOGKte1b5pv/eQclRel+h/A/yfdFNmYbwrpHBu4zf24Lked/jZH/IJUMtSqjBASex7+6ukKLGkUTqHjSQtC2eWGrwiTPQXKzMIA2A+LM1SDfvhIjPg99vsHx6QO+gG1THjbEdH+EROHsdAqIiUd1c6RTlSuFTyxViCwNkJStkBPZzxcNPKz2SSpnJnT93L8L9L8Yp3KE2Egh9EvovvluyaG/atNIWZeMkAdiaF0tBVDfH5RUMrIrM78vKF2BzO93YjclKnqVT8l2sIAG59vrMUI/fuPEu4na1VQnHSvnX63gXPKNqbCotQbWAQBzuNX+t0V/0sAbzS
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2019 05:37:48.4631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f444f4e-e564-4693-1378-08d7577b2399
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6657
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

+Shubhrajyoti,

On 22. 10. 19 17:20, Mark Brown wrote:
> On Tue, Oct 22, 2019 at 02:06:11PM +0200, Alvaro Gamez Machado wrote:
>> On Tue, Oct 22, 2019 at 12:26:00PM +0100, Mark Brown wrote:
> 
>>> This is still something that should be configured by the client driver,
>>> if you send data with a different word size to that the client intends
>>> it'll just get corrupted.
> 
>> The problem is that Xilinx's AXI Quad SPI core doesn't allow this. When
>> instantiating the core you must choose *the* transfer width, not the
>> *maximum* transfer width. So in my example above, no matter how I configure
>> my IP core, linux'll believe that its datawidth is 8. I could override it
>> hardcoding a 32 in spi-xilinx.c, but then what would happen with my other
>> IP core that needs a datawidth of 8? Client code cannot configure IP core
>> with a different datawidth because it simply does not allow it.
> 
> If the SPI controller can't cope with sending anything but 32 bits
> that's fine, the slave still needs to know that it's supposed to be
> handing the host controller data laid out in 32 bit words.  All the
> components need to agree about how the data is supposed to be
> interpreted.

Shubhrajyoti: Can you please comment this thread?

Thanks,
Michal



