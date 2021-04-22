Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01099367E9F
	for <lists+linux-spi@lfdr.de>; Thu, 22 Apr 2021 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235704AbhDVK1y (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 22 Apr 2021 06:27:54 -0400
Received: from mail-mw2nam10on2043.outbound.protection.outlook.com ([40.107.94.43]:48417
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230285AbhDVK1x (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 22 Apr 2021 06:27:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j6A7SGDWRt2jksH8QmBCjtx+ejU2Ehg9Tkmjgaz1NJ5HpvrMitzlhTCUMmq1hwwu846rlvw2lGqeT3IGMDpruBD9fItGH/mxVSc3kYkRCLnMOZdZh/kzq5FExcuM0ki9nwjnUTRDEZA+jVd8ix0aFxvd4Xd6mde2ox4ydadVJ/A4PqOIYlTzDxBSbKraHvDIgHsWktLGO1OITwhwEBgYN5O6dkglKAfHS4FQp8bx0/vNCTfUIb8W0BnYY1kj8cQmooRT9As+k/5XZWnB5CVZaKqxMmSAfDk5hmoBlK2AYbnd+XSgj0PaVNsoImRC2nO2It2I6OTqM5gNcBbAnhLPeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVkwLipJFaH9rdUTx0siAOd4Bbh7ja8Uh+oBoGMsinc=;
 b=fsp9UYNgxLOEUbBL32Xsa493s8P94Vm/P+ZPaG0czVygQScnxhc6GzPRfkxNngjrjJxYtEUwVf4NvizJB8BaB2e3DixQQK2PwFBtX1hlo92ztogh3H4gVW9oXbeYPP9zabaoiGGKlJQOSOp7+xG8ggZJDOK148OIXKdljIViTB1QWXKAyEGzkQ95zF54WDm7KkAHZbWkZUsDZqHDKageMer4w1TcBCJ3iGbu/Xfd43ahB8f2tZ+avyGnx3i1Qr3YJm8G965OgKshcfSYrQ8EXjvQ87h+9M1HqwjHa8HyS/5NCjD9BQR/MnDj0W9qrGZ5RZurk7/FlJpFRXbtdwqCNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVkwLipJFaH9rdUTx0siAOd4Bbh7ja8Uh+oBoGMsinc=;
 b=m6oTqkl8bqxONhPMdEub/Gxnik7Rjnz+HgAlNw7cK+h/r7s5of65yye/VJahGwK4lHfBn1XXGbKQYn4yvf9Cxtp021cjnwDR1Uk7+xOGRz3HnVslvv7nUR5CCWJprzd/Di0YaFzxh6QM7dSKoc6JKEa7iqdaWJ3dgQwdlRq+gbI=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB2006.namprd11.prod.outlook.com (2603:10b6:903:2f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Thu, 22 Apr
 2021 10:27:17 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.4042.024; Thu, 22 Apr 2021
 10:27:16 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH] spi: tools: make a symbolic link to the header file spi.h
Date:   Thu, 22 Apr 2021 18:26:04 +0800
Message-Id: <20210422102604.3034217-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2P15301CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::19) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK2P15301CA0009.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.14 via Frontend Transport; Thu, 22 Apr 2021 10:27:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49ed1ea0-3ace-4cb5-12b1-08d905793378
X-MS-TrafficTypeDiagnostic: CY4PR11MB2006:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB2006B2B5D7BFD54ABC937C75F0469@CY4PR11MB2006.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8v5JcS9zAB+UPwWhwKwNYTsqpqPrZCGxZ6m+dTt0B4zjmaxF/mTeFbVnfo0CwywU37RJT82sSSf+xamVni/YRVAr6lqbLUvUSL0nwg/MJa59WZxN1VRfa/8yIG8WmIX1mwvNWV4c1t6C+oZAYGrkA84n2fcbWbJ+JgTEJ1v3TMDuQStuE9QfSJ1DqxoxEnhPotU2HKXmARHWfKFipUzedFvsfZPq5rpapKNSRSJBNtrL7F0QZztvYpvKUHH7LXFEy6+SnivMr1UAlm6olHUinFrWCEVU6fLLf0WVqxt2iRBttpRN5CHruxV1m57bAjlavivaTfQPmSRAMXB9YFmSW/OX5J1XkscK6txlZ+n3e02ZeP13amV8cNLi/abngAd93pvLbNLHKJItbNfV+F68sYby7dJTQXpVNCSCezL8J8+cGTZo84C3H8+0IDTnXkFzgf9kJ/9kyj3OXFgJ37EMtWJDkwseOSmBcOX1mUL2KzNfhZtl8NDBCPSAeF5ia5LHXJzfVsM3GTRc6/InxNkVu+pnNeAS6/Sv6ubeteyVwfDsyfMOLaeqCdaf2CKxi8O3gcZhIiMajUqzUrg1paXM7sxccL5DPlLUBP2dtuIHxic09wMKbacixkAzIpaLXJNTPsCNCVaem7zckEbbt2sog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(39850400004)(396003)(83380400001)(186003)(107886003)(6506007)(478600001)(26005)(4326008)(66946007)(110136005)(8676002)(86362001)(6512007)(956004)(316002)(1076003)(5660300002)(2616005)(6666004)(66476007)(36756003)(6486002)(38350700002)(38100700002)(66556008)(52116002)(8936002)(2906002)(9686003)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ISsBk31Y+j1QnPcCj+JTPWR/M76y6RoxBodUpq3Bsv6MnqAeMwLUWyEYlaWV?=
 =?us-ascii?Q?grDr/HD4pntfbcywMZQ6CEPfxCCCn81HMkHW6TB4p9jHwiHodsXzVV0wT8ts?=
 =?us-ascii?Q?tRmL0xQJu3ruknwN5qQB4av9WYktVwUKxua+ErdRZXjmcOCd5W+wjyEsVgns?=
 =?us-ascii?Q?48h6otZDZU5MgvQICOSxscosHRdj6yqNSydIAvtX+3W6djoD5HfkYqPKNT3l?=
 =?us-ascii?Q?ofGLHW/uprJFPozpBIDnrDPXiAGrQY0rV9Gl65GnfYJR5XTGUlhuE3iiwtjo?=
 =?us-ascii?Q?OxCiqoUDr6GzV2bk48y10CNixp3T2LJtxJmhkARkC8PBPaGXPUQdANiwiMgn?=
 =?us-ascii?Q?GIEUZQrFMPjdqUXwvJEz9OLdASYmZY/XRidl47TP0X2Br787GnYGe0sl6WDs?=
 =?us-ascii?Q?uwoj1aAylV+aJSViV8UEzc1PEvoKDUJKhqoz2L/eh/93Y7bD7sm4FVnZJI8t?=
 =?us-ascii?Q?HOIEMXNUmifhXVcHSzoiYoArlZ7Zt09jOqLmtCLiWDKf8dv/fp9W7cnRMIHz?=
 =?us-ascii?Q?cqofcl/y+Qwp6kRf9QPqZ417lFKneZU2v304+moAPhvXfSHJkpfZIsB8ciuC?=
 =?us-ascii?Q?ZiJ4eOopf7iGyutqGRWcR/nquwlpeNBNyhPE7oDLsCawsatKDjt1616+U9Aq?=
 =?us-ascii?Q?nuQ8jlC1REPRjnDhoGnCc4nlCDKeAfODAyXn6L9OTs52woNRNM0RX6W7LWVv?=
 =?us-ascii?Q?riPDeNRfPdKIDnlzM1Jw045BMCIfvP7Nxuw7k/7JIOIHw6paydao88ASRucp?=
 =?us-ascii?Q?+XFJrs/rPGh+MmJXoQzB1FyJ36G7XEKDdbqc8Oa5k8YF6C6nj+N64hnSQX9y?=
 =?us-ascii?Q?+o7Um7k+ulpp8J7ToC7PjcGRIbVwV0dAUv6MO5doP4S/kFM7v8N8EPl6yWiB?=
 =?us-ascii?Q?3otGEQySLj2H2+X4JY88NweQzdm17f3eTsXfu7tmihWRIh6/fZ8iigaeBbQz?=
 =?us-ascii?Q?lwd1s7UeaAyHuwbY90+wLIuM0tI9feIpaZ9FdPdFc6svCPWeEJdqSl1Xuglb?=
 =?us-ascii?Q?b9WRJEfHnMqmJL56X5XXNcwS62K5ZW1d67OplQlswqFAvFyS8Nrjthxpbv1z?=
 =?us-ascii?Q?Z+6buOZUNDEwjh4XsTWac57/axyPN5oOLS28PKdwNT09p4E85UWBbYpHYFmO?=
 =?us-ascii?Q?68aGFMvFo0HrcOZD4Bs1L9TKjig7p1JMImI++5R1kN9KoGvOFP0NFMTCxleC?=
 =?us-ascii?Q?MFNQXbQuhGEZO4qi/F0siSggP7DMf1vPqjTBc5Y3Xywz+I0FPUlEugBlKbBw?=
 =?us-ascii?Q?Cj2Sqf5dIjy5sSl58z/khTqwF+hOUf4FvdqZ15X+Zznkc84crgRi6VsjUCbn?=
 =?us-ascii?Q?URpuWPI0kGyd/+7G4R1iCfF2?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ed1ea0-3ace-4cb5-12b1-08d905793378
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 10:27:16.6232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ibpPWjglXd8DtIFTmBcf0jmYjLinVKjb3pixLtdB+Fd262YzI9NGlzRzonK6UTTjpRtnYQ44doKbIhmdRujNaU99C8Nug2lAZ3J1BN6p3PU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB2006
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

The header file spi.h in include/uapi/linux/spi is needed for spidev.h,
so we also need make a symbolic link to it to eliminate the error message
as below:

In file included from spidev_test.c:24:
include/linux/spi/spidev.h:28:10: fatal error: linux/spi/spi.h: No such file or directory
   28 | #include <linux/spi/spi.h>
      |          ^~~~~~~~~~~~~~~~~
compilation terminated.

Fixes: f7005142dace ("spi: uapi: unify SPI modes into a single spi.h")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 tools/spi/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/spi/Makefile b/tools/spi/Makefile
index ada881afb489..0aa6dbd31fb8 100644
--- a/tools/spi/Makefile
+++ b/tools/spi/Makefile
@@ -25,11 +25,12 @@ include $(srctree)/tools/build/Makefile.include
 #
 # We need the following to be outside of kernel tree
 #
-$(OUTPUT)include/linux/spi/spidev.h: ../../include/uapi/linux/spi/spidev.h
+$(OUTPUT)include/linux/spi: ../../include/uapi/linux/spi
 	mkdir -p $(OUTPUT)include/linux/spi 2>&1 || true
 	ln -sf $(CURDIR)/../../include/uapi/linux/spi/spidev.h $@
+	ln -sf $(CURDIR)/../../include/uapi/linux/spi/spi.h $@
 
-prepare: $(OUTPUT)include/linux/spi/spidev.h
+prepare: $(OUTPUT)include/linux/spi
 
 #
 # spidev_test
-- 
2.25.1

