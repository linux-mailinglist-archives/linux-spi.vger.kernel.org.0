Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E439822E454
	for <lists+linux-spi@lfdr.de>; Mon, 27 Jul 2020 05:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgG0DPK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 26 Jul 2020 23:15:10 -0400
Received: from mail-eopbgr70071.outbound.protection.outlook.com ([40.107.7.71]:2453
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728005AbgG0DPK (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 26 Jul 2020 23:15:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfBy81JrpVKRwfmO4JiTZtG+A6gc+KyciaW7U+ChPrIoHvECgSKYmQr27y1E7uO5TWAWXS5j39uJzCDnck+jt8/4YFbdevDpFeC++hCp2Ybe5vcf6YuCCueVwO3vud4JFTyXGuXLl1ErJ0FyG8fE227AaPH36YEl4lQBRprxthJ+euN+Zr6gjUlTelcAWObOHuVFV1mfMDycNN6wf8B92T5ZhdwIXJ86Oh+IOxA0xRM2EelNDf91AEkmgP7fVNyuG5n0bKMjzPdRcdHVp3Ohnpy65JN41VnBLFiThmEaqH69nPmVU/dqGMYCPiGk2fPaQOCrWXok8L2NFmQ7N4XzCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyQD/mohmovBFiPaqgEIxcyggY8VtPFEPLcJfoubqqo=;
 b=LWuoulnKPRGnoADggFe4mkTQRjN/QGWFwhXF7C0xr5Vu8u4heFy1If9quIZ/8Zioxy9a8+eqGAVle1NbhbRuunKZg7lQ+q5b76O3YynONvVxcgrQmH+pzpyjwFq+HcjShL9QM1nfuuXPSmiRFvM7M3O/afIloHr/PA3uCRdENCTActU3EfyvwkpGw76XHaE/2VRkaBRvaUHP1BIxC+8JS5fUUtC35Hhv6Zbi6Omsg7ada/BML5iRTyJi9BjGOJaoNkShFC2AzWccMHG9b/5QEuKIdIjxMFlMbniHxkOp0e+VhIEj6bTIO9cOZZ1ioOO0o4oeUcF1/vA51xlpc45DFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyQD/mohmovBFiPaqgEIxcyggY8VtPFEPLcJfoubqqo=;
 b=PUg+WSl6zrbFvNwROg5QyY5ZYscQztuFt5tbIc5NlNMwJUNHu1NyjNoKrEF/pstn4T6kM4XQ5tQNtgJjpwrwFKxDY8JpNQdEtmBezmghuVAExCmoKAC1n9eVqZaYKqXmf6KHLKYh4Alqk1m3PRI7lT77TcpSV1bdY9FVTS6otUs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR0402MB3880.eurprd04.prod.outlook.com (2603:10a6:209:1b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.31; Mon, 27 Jul
 2020 03:15:06 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694%5]) with mapi id 15.20.3216.033; Mon, 27 Jul 2020
 03:15:06 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org, Anson.Huang@nxp.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/4] dt-bindings: lpspi: New property in document DT bindings for LPSPI
Date:   Mon, 27 Jul 2020 11:15:13 +0800
Message-Id: <20200727031513.31774-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0151.apcprd01.prod.exchangelabs.com (2603:1096:4:8f::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Mon, 27 Jul 2020 03:15:04 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ffb70e70-0e53-4dc9-ffc3-08d831db42d9
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3880:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR0402MB38808DD27E49B5B70727F9F8F3720@AM6PR0402MB3880.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oiqOudFvjfg0VAtbyiruOtelO4D977Xz8/RjIpJeia7qg/W/8Wit92+4N7aFzbC8SVWtN+A4aSCdQJtikV4+jNwIe6bM9ek+cInYD1R8HoGYUzLKDKMCO4SSrO0k8EYyOo8wm9FY5I7KNclsjrs2yBYUlRAjFgxERFWRkdbzrWMqQ6SQOkQdr/Qf5iLaxIBI5hGo6FQ0H/uZr2+HOAeVQAWk1MviD5PyoGApkQWVTM7++TT6Y+6rROS6vekMJNj9+PS0ACYMTBzyhZb4XsnrX7plEnfM6hDXquv3LjWZASjRHRPkmCXrtRFRL3u4o2bDJc6HEGfk8IUZ/degLhJexvXp9xsYYijVzrU02kUocB193sLbwOu+VdkPTPxAGlWZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(66556008)(66946007)(66476007)(5660300002)(956004)(2616005)(8676002)(478600001)(6512007)(36756003)(316002)(4326008)(6486002)(6636002)(1076003)(6666004)(26005)(16526019)(52116002)(6506007)(186003)(83380400001)(86362001)(69590400007)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ktgOimpwFpeer5vD9J9sxyaI2utqZ2GM0qcPtuBNNENcZbXFdbCfIP7ekIAmqtcz3ZLVGztmQaWJ8wws39s41NWU6YOqcd68a33x9rZEa697Rn2F3LTcA1PATkD6L/YutANsbHfe6XX4RABkB99vZMaZUgPRB75J8M781WZQ8CdVDvJwAzKq8QUUxTPpzyJh01vTvAc0Y3ihaPONr6BLIyi8bfZcx6/qEm0zEiNeBDsIhUqoXPYSL4lr/hS8L++uSTSKRpw9xXKrLE4rGqhuety0+O70FHq+hWQCAl5J4J6cS0AaXGkq5EtCj6cvFtaIWGaGEl7wT8fo4M0lXaTVKYVpHqVeEBhojgAuDn0fHiPcvLzAhD+PiuPR1/6vLY+fSCkra6AqAtrykfAokvwMxvQ5QlUhuaYwKBpcqlYC+5N+5dTIVPfdhibDvIZcInitNrQaawBtH+SLYjZ7ddVpJCyDa9iyQqchaug34j3xkEU=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb70e70-0e53-4dc9-ffc3-08d831db42d9
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 03:15:06.5095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PUmbuYfWXhOzseWvWUpeKZxhpQ+Ncs0KgmscdKdinlLzasR7K4BwNhsa7B/fzx6LbIBwdT5jt54bbwsSC3nNOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3880
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add "fsl,spi-only-use-cs1-sel" to fit i.MX8DXL-EVK.
Spi common code does not support use of CS signals discontinuously.
It only uses CS1 without using CS0. So, add this property to re-config
chipselect value.

Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
---
Changes:
V2:
 - New patch added in the v2 patchset.
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
index 143b94a1883a..22882e769e26 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -34,6 +34,12 @@ properties:
       - const: per
       - const: ipg
 
+  fsl,spi-only-use-cs1-sel:
+    description:
+      spi common code does not support use of CS signals discontinuously.
+      i.MX8DXL-EVK board only uses CS1 without using CS0. Therefore, add
+      this property to re-config the chipselect value in the LPSPI driver.
+
 required:
   - compatible
   - reg
@@ -57,4 +63,5 @@ examples:
                  <&clks IMX7ULP_CLK_DUMMY>;
         clock-names = "per", "ipg";
         spi-slave;
+        fsl,spi-only-use-cs1-sel;
     };
-- 
2.17.1

