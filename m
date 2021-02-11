Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26023318B4D
	for <lists+linux-spi@lfdr.de>; Thu, 11 Feb 2021 14:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhBKM7V (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Feb 2021 07:59:21 -0500
Received: from mail-bn8nam11on2086.outbound.protection.outlook.com ([40.107.236.86]:2017
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231408AbhBKM4K (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Feb 2021 07:56:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpcI8YvG0awWQ38aetNiwtBQAhn4KmuyvrbAjF9Xadq20VdNRdZIHfQG9yi3q+SW16B+e98AbzmqyLhcamZtnUP0aOR2YKRLhB7T34eTKV6qQuhGoYnvfx3OTNxJTXTn1/IbDuY0Y/vGDT7qpHIWL9J5Oho8v3y68lEHFVbemKj51qXTDJmr09nZbEPryF9voxs5PHLN+/6p5C1OQur6b5/x6qupX9jwtJ7gUdfRzbYsvkg0Q0xa1EAjcI2YnDtZPB3ekLCXBllHoUUvsruX/eIt+L7OWmEs0/7cM4N1fzz039Ba3qcXtggDfmjeuzr2kjJQ9/tOXtTXgyl4p9xn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77YK1UA/e4S1dhvg1TdZ9WFHvxl4N9GRk0G5/sWe9GY=;
 b=GmeHO8hceUaHGTkzNQ+aHJGo39gnDDvpPMIsqg54IOoapJrOFgUWrWQvqBjyy94Vg0plBPe781P1qTK2ZalC2Gxxn1nsxsLAvchlPeZu3rahtNhJ+MRgO1a24LhKWRDOhlKrQmNEh4mtd+dUyDvVgHCgQByLZV/9HqQtP/HXVS4/hBE8ImguTuyvwMYRNCKll66nbX5rHFggc5LuqfgW06SBDSRVNWAQBI3FfQWt83nNvZh+xKzi/F7gWRegW51YdIz36Sc/ChGHbAkeMRo9ztnNBsxl1bLYaz5uZeghsmFMbpMjlFuL4KXjVU2GmeuIwwV5MXOVsgMVBkfs9+B6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77YK1UA/e4S1dhvg1TdZ9WFHvxl4N9GRk0G5/sWe9GY=;
 b=GQpmNr1Pt/G3HCYJjUi40E+UYXT+MQJa0mT77hcpP6Zl+cQsUqe+S7Xuo86qWDfWtSggibchL5HA2wbMvhTyk9G07Za0LLfNdffAQJfAPP2FEpkKi3dqlfVJaUaHAc+C0dKgmDGWXe/sQxiYiSlD/0HbLX5kkz42NTmbEx9lDJk=
Received: from MN2PR20CA0054.namprd20.prod.outlook.com (2603:10b6:208:235::23)
 by BL0PR02MB4738.namprd02.prod.outlook.com (2603:10b6:208:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Thu, 11 Feb
 2021 12:55:15 +0000
Received: from BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:235:cafe::98) by MN2PR20CA0054.outlook.office365.com
 (2603:10b6:208:235::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend
 Transport; Thu, 11 Feb 2021 12:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT032.mail.protection.outlook.com (10.152.77.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3846.25 via Frontend Transport; Thu, 11 Feb 2021 12:55:14 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 11 Feb 2021 04:54:55 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 11 Feb 2021 04:54:55 -0800
Envelope-to: git@xilinx.com,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 robh+dt@kernel.org,
 linux-kernel@vger.kernel.org,
 monstr@monstr.eu,
 broonie@kernel.org
Received: from [172.30.17.109] (port=49554)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lABUk-0000Zl-OC; Thu, 11 Feb 2021 04:54:55 -0800
Subject: Re: [PATCH v2] dt-bindings: spi: zynq: Convert Zynq QSPI binding to
 yaml
To:     Mark Brown <broonie@kernel.org>, Michal Simek <monstr@monstr.eu>
CC:     LKML <linux-kernel@vger.kernel.org>, git <git@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>
References: <4ece21a7e9691ed1e775fd6b0b4046b1562e44bd.1612951821.git.michal.simek@xilinx.com>
 <CAHTX3dKPTC1+awBADMCcgX+=PXsHPw2Bz3Po5=CocdKzVy3bRg@mail.gmail.com>
 <20210211123907.GA5217@sirena.org.uk>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2421214b-0f7b-93a1-c718-f0b96caceafb@xilinx.com>
Date:   Thu, 11 Feb 2021 13:54:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210211123907.GA5217@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b7a9486-d8c4-4663-f4ac-08d8ce8c46bf
X-MS-TrafficTypeDiagnostic: BL0PR02MB4738:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <BL0PR02MB4738B599582BB612DD21BE26C68C9@BL0PR02MB4738.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zdL7cIX5m7Cvp1DCOdknOQWPo7y5uULolm9HibKBLhPyuz942VGEAbXHt+oNG4lQnuMMUdaR1XVe/FAiqoWoGsajojqkNyrD7V7r2XxbJ66y/ka/HnONCTQWHUdo3zG9+u71upP7DT88dR7C8s6o6uqu0DiLQLylLpkbeUBGJfFoZG9PgJcA28pNVJpOBsixeRe5FxfMnbu9O6lTdES/BfP0Lt3hnQHshyL5Nr0Cys4gLiVnWVx7RD/CZNIyDb9NG8LjPj5TJ2z9VPV2XeSdcTY5VQxmlWkClR1SM65xL0jcNMd7GJC2x1GSq2xHgA1by7ZTOxY7eeONd36/dDSusXTYK0CkQwRfhIP6jnrC6S+H2z6rG8w3z5e2ZBMKWd3lK6TmABd35AMYVWJwJ9kjcjLrJ2ZZ1qngLXFuY238obvhS9s++lkR2Sx4t7gGildXV+klcszVYLAcwYxfZD1BOJNAtrUaKD8uUax0lTMMr9rsN9EzR7bzqw1EO5fk5KRT80Gkc9hOlOKdIRdfnQl/+SdlGfU8ukpLkXouX3eAmLecNAkMjb7EuPdh08s0Gi5Eyt4XFG6UMBdvHXyyGgFV7ni32uzsyUDL4r2rEJlyjxJCzeKe4f5tAt+szipi1SdtGXQZCG1DSoM4SB4cCG42/SN8PpeZj4RcfS5byD1CTSPuVhbSIDGw13WKLf4QBKqr5CcxtAd8GFk0Tsb35AmqOg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(47076005)(53546011)(82310400003)(54906003)(2906002)(36860700001)(70206006)(70586007)(31686004)(316002)(4326008)(9786002)(478600001)(36756003)(426003)(6666004)(4744005)(356005)(83380400001)(5660300002)(336012)(36906005)(66574015)(8936002)(44832011)(7636003)(31696002)(186003)(8676002)(26005)(2616005)(110136005)(82740400003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 12:55:14.9254
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b7a9486-d8c4-4663-f4ac-08d8ce8c46bf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4738
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org



On 2/11/21 1:39 PM, Mark Brown wrote:
> On Thu, Feb 11, 2021 at 10:37:30AM +0100, Michal Simek wrote:
>> st 10. 2. 2021 v 11:10 odesílatel Michal Simek <michal.simek@xilinx.com> napsal:
> 
>>> +description:
>>> +  The Xilinx Zynq QSPI controller is used to access multi-bit serial flash
>>> +  memory devices.
> 
>> Applied.
> 
> Doesn't really matter here but I would really expect subsystem binding
> documents to go through the subsystem tree.

Sorry about it. I will keep that in my mind for future.

Thanks,
Michal
