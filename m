Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75463362415
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 17:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245739AbhDPPi0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 11:38:26 -0400
Received: from mail-dm6nam12on2043.outbound.protection.outlook.com ([40.107.243.43]:48192
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241097AbhDPPi0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Apr 2021 11:38:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTiU5h6vfp4KcEalntzPQizsNqCF3fQio0JE3dtbKmqR/lBB3xkHMSCsmxvSWwOYeYUGW4J4m6qTIgTLda92EpMGIODGXRHcO/Te2PZghavP4FZx5bKEESQxGFYBnGQl/FhI2+ByvC/rwp/YJCTM3LxX+OQqfInJ0DyzJv2XGmpDoe1o+wucor9/i7Kt80AAdzoKUAtELlaBU6NOqXm6mdZY27jhs1pzjUWPkf/ikjKxZY1slQHlKKqtip3SPN/4xX7195CWtJePWqS7E4MbD9Rf6sBEzvAU7joEIAPnJjOPSTuwO17BTiwDEubdNfqiX8/TmnKTQv7BSmRedwdwpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W6INf0n7RwfJpCldr2Du66b8ZID3RT7+RTKjZwojBo=;
 b=FASr2EhJiq3F046awHP6FtfxaCLVfDT9a0jWlbjc8BLx+ieqMaHNFLire5wl3T2p5ZCnJawq5Awkm0eVrWLBYCn9ejh2vM1Z8f6zCgFwIBRifWDa6wK8ZyAXksxCILb/IoambIB7jHRKNBH86AFvRnP8QtByauPi3WjXD2kmAKhwddVXs0p9/LhDcNW3xwSxOwgFG39kf/QbniA0eRF9SCLoRHO9xeQfeOQIHIBYSJD0V7FpF9TGgxvR4GOucOMDWlz6L1zL45n5VuU3WscrJZ2no0maMy/Q3XlVCySG7aG/I6svZ0CPMcxlK2gSdIs3RQ6srZcPM33eeYeIQA3Zuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7W6INf0n7RwfJpCldr2Du66b8ZID3RT7+RTKjZwojBo=;
 b=OOrq+MJi5anx38DB3TK9dF0Q9m7IziVsw7bt6caYas59A7F4Ud/TIiAPEQdHnvjQVNaaVnLuYbqY4MSI7Xz5o26DrlRrWhp7v7mPsdr8wwgPO5wSmMYBglAQDtqRx+ETqAwXwSfz/X+M6/0IUOhVTdZ6sUzT+82fjE/V6MfHyf0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2342.namprd11.prod.outlook.com (2603:10b6:903:b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 15:37:59 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Fri, 16 Apr 2021
 15:37:59 +0000
Subject: Re: [PATCH 1/5] spi: spi-zynqmp-gqspi: fix clk_enable/disable
 imbalance issue
To:     Mark Brown <broonie@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210416004652.2975446-1-quanyang.wang@windriver.com>
 <20210416004652.2975446-2-quanyang.wang@windriver.com>
 <20210416125558.GA5560@sirena.org.uk>
 <03f4152a-e66e-6b4a-5b4a-5f79f9ce2302@windriver.com>
 <20210416151235.GC5560@sirena.org.uk>
From:   Quanyang Wang <quanyang.wang@windriver.com>
Message-ID: <1c7f42ed-cd2f-4fff-61c9-4460720dfd84@windriver.com>
Date:   Fri, 16 Apr 2021 23:37:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210416151235.GC5560@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [111.196.167.14]
X-ClientProxiedBy: HK2PR02CA0168.apcprd02.prod.outlook.com
 (2603:1096:201:1f::28) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.109] (111.196.167.14) by HK2PR02CA0168.apcprd02.prod.outlook.com (2603:1096:201:1f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 15:37:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e97dbd3-d7a7-4ddc-0337-08d900ed9d1a
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2342:
X-Microsoft-Antispam-PRVS: <CY4PR1101MB23425C9C185AA9CBF9293890F04C9@CY4PR1101MB2342.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAR8j8dWxeMejudEOVZQOCgEA1eMXBY/2TcQh56/kgu4aDGEU8KjJ3Qk6Nc51sRn6vBBUXCTs5UbI7+A5al4vqMeQn98uo3+CC2zjxzGVBFxc9pe8N31DKp2g6GnZ/NeSIviNG8GAu4VlPr0q3FlxiEU4tRfaj6ID+M9OKg6ExbH573KTZzBlQHLYf5ujz2Br/sTL+63Fh5pMAx10DSqKhOBeOge5MOKWQQK8d3CASp3QkSLX5/Hf284V7+aZ+iQMX2/ONj6SbmlCpKEAavDQQupd6rfNx4BFvGkmICJ+uBYTNCBtiwS4YGXHJfW0Je4l93s+KmeqSYhp3lu5Od9JECelMZhBR2pI4vU9M8D3cfzjr/4tGW1S67eGbIPC8+bxI2/TdabezOY/K7RBs4H14C44qA1sy6HbKCe+PLzMyIQS6PVV3OVYZelxxj50hUs8zPqYA0skomy7wX3Ga+yN6uatvT8dpMFoyMYldP/+BuhN4tOu6Q4bGSC8s37j+mzRxktC9DAsHCmXw4URPtNnB+LP4BgAWs4rkA5FbfHzsIdUZVrUXo3pOZnZFn6WKznAvvvxOCSAm8nsYqRmDIW8mGudCKeqacF1FeTrghFkyBXPXuVfIm9LC1pS6Zi2tsSH0y1q5YzIGEZKemCGCblqphpKrkdx67l38vqPUkUqons3cq74y2gl6M0RtMlybBIajMWDplnBOEDCpecNGIF+Pcau6iP6L3U9677UDTtOlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(39850400004)(396003)(376002)(26005)(16576012)(4326008)(6916009)(5660300002)(956004)(478600001)(16526019)(83380400001)(2616005)(316002)(186003)(6666004)(31686004)(36756003)(31696002)(54906003)(66946007)(66556008)(66476007)(2906002)(8676002)(86362001)(52116002)(8936002)(6486002)(38350700002)(38100700002)(4744005)(44832011)(53546011)(13296009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?JBWjlM3W0oK4Ie+bxzmDXSCxnduQaXmQRleJpHbGl2PZVbmkK3nAy1vU?=
 =?Windows-1252?Q?fCkA/3raGBTRgf69qZgIPkMkAvYoIdzgZsjP80XIM/vnmn6qC6Np0Jv/?=
 =?Windows-1252?Q?+1+IDl6UBhiEWGhvwEHpWt3SZC0YNMdmjtpxtiS+EVYo2DEnAh4yvg8f?=
 =?Windows-1252?Q?R200iwyoHvjy1VjnHjAWrXz1xwZsA1AFBrp49EaXNWukdT2uVht4OHcz?=
 =?Windows-1252?Q?Q9Zg9g9LklRiUdIyNJujucBqal/8imAllU3qzs8HUJ1r9E+kpbCLNdZ1?=
 =?Windows-1252?Q?oCU36pWEXraUOsUyyVmQxrWnZLMPWZ3MXRv3RRVzfDITDtBtApWSxX3N?=
 =?Windows-1252?Q?W5mCorvnjZiT02KtNva5+YqpoTMdmX/utoMn8CtmEPTKmf21sbuT888U?=
 =?Windows-1252?Q?Dd6JZRt0EC+ssCe8Yis9RXV/lMDWXPaybTWL+bgTfzvfgfsdmfvobARU?=
 =?Windows-1252?Q?9XgDKTjM7G19tOjoPwpCNt6b6INzDBBzgzNXAore2E85ATi1ixUi826D?=
 =?Windows-1252?Q?KFWDrz3cjxUVgZr4u/36F74P9aJk9igOehWiYVNvw+A+e43BfEceAQhG?=
 =?Windows-1252?Q?Jr2XfcgkLbqN5H7wvFdOo9dgX+wzIJG4jJHlN7WkhM6wp3PLG66p+ddE?=
 =?Windows-1252?Q?DZEA6U1rnhDOlnWJAl8FoIgJpNyxdJPGPfs2qhrRxCIc9tpMxyDmtDHi?=
 =?Windows-1252?Q?xSFAOo64FCvvNXWW6dbekfzPEor3zuYm05uWcxnqGGqLvoaCwWxzhqhF?=
 =?Windows-1252?Q?9a8vE3lPryO5EvNemZkyMhE551Y7xSeeA05JTTkEz8KZQPGJAWqdh6cC?=
 =?Windows-1252?Q?DnlpFwCoMxj243qya47XhAfy4JQ9tcq518QmEGEv7lWsuLU2xdvozHW4?=
 =?Windows-1252?Q?ypcnlioXHQN94z5KrkxCOzMfPQuFDL4UF9KbSunHpZJfdpVnfe5U6xI+?=
 =?Windows-1252?Q?j37m5M272j20aT2Ubx2zTrxPARoL2LOAXZwUzHow4oZmhfLmYbLdjujL?=
 =?Windows-1252?Q?MAE3oXh+Renv1GHSSAMiQzti6wid7irPROOET6Xw5jfKf6pT5vbC22In?=
 =?Windows-1252?Q?eNsAc043OhR5b2AieCZsEx73nmmEMBGoZTtBYuX9XsQTLvbrSxy+ihbo?=
 =?Windows-1252?Q?AKQgFVGrkGZSOAEAqkFBwR0tDWvvbHWXOVMij31N0s6WvuDvtV2myY35?=
 =?Windows-1252?Q?wpuscqLFuzOsrLBFq9xoDURjljCsIRzgGSkPBQR4Gxo7DE0C899eKIDj?=
 =?Windows-1252?Q?Xfy1itlSjPMKJ5NieAfm+yGMSq1wSPEA2HAEMaKD+ykrZntpE6tIEg1o?=
 =?Windows-1252?Q?GA85nDBfOfcO4d99cawRKgDIOOAktfcBG6ptX4C/Ulv32Kq9eT3jsZbo?=
 =?Windows-1252?Q?/xDqVLxxdj588nXAfDo5nIrhlWlwLPIViMIzAIhiTXKxUjz04fqAqtBN?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e97dbd3-d7a7-4ddc-0337-08d900ed9d1a
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 15:37:59.3582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: joWOdtoy7GK1JubmuvHX1Z4I84QYlBRy6xBlh03+EHzRwSAc9P3E0gd97WHy4GuAg4dQBc3ghg2JC6ZHVar6sVI9+4Nu6RAjGftgNccqHts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2342
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Mark,

On 4/16/21 11:12 PM, Mark Brown wrote:
> On Fri, Apr 16, 2021 at 10:04:30PM +0800, quanyang.wang wrote:
>
>> I am sorry. These patches should NOT be with "Fixes" tag since they base on
>> the patches
>> which are not with "Fixes". May I send a V2 patch series which remove these
>> "Fixes" tags?
> Well, if they're fixing bugs that were present in the named commit then
> the the tag makes sense, it's just a question of if they are actually
> for that commit or if they are fixing things for other commits like the
> runtime PM enablement.

Yes,  they are fixing bugs which are introduced by the named commit.

But if only picking they to stable without the patch "spi: 
spi-zynqmp-gqspi: Fix runtime PM imbalance in zynqmp_qspi_probe",

this spi driver will not work. I don't know how to handle this 
condition, so I send a V2 patch series to delete the tags.

Thanks,

Quanyang

