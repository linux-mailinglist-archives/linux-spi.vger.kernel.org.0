Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C1A21EA99
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jul 2020 09:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgGNHwr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jul 2020 03:52:47 -0400
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:64598
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbgGNHwq (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 14 Jul 2020 03:52:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmPPj7Z6rISNvAwYrTNqlHUiYmCL8gLVR2oTjIOOyJQVMgCI/6iXutX2/Q1ohfNDFNi+1Qm7vPeDRpFBnQCPmHdPlmkjMyOTuDjw+YW6+AvXB2cyzfMOLAnWvf0m/7Wj/x9kQFxVyLk7YCgHhwpJG9cov/t38jH7cj1dhIvHwURAK5r8nW9vvXUPpR7TPpGrq0QIfF4yzftU+KtDM0+g1H0iu7o8qnA4uqdPvF90gB8waAeh2vl+AcoKUfrlOv3JkhURnYbZ4/dwH/4g4vZt+jk5Y+BYi+okgxmhyx8KFRLqICcBs/6ZzzXh7K62nZe8Q+cLFUz8oSDXRqD8uhzb3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uW0pP5NhNm3AJXQZIrhaybGJp/hv6IH9UgIkICUD+M=;
 b=dfDCahrlD8w4gn17Zh2W0KpzzOK/eGo9z6JvixdprRfukau+2ekyIs9uqJNui7b0nQvet0eALkhNBRkO+AW+mV1QF6gWRGXW6tw7HxjSCqwrV7rNs1zfP/gM97nncn8bx8jcT9P+8eAa91KVG435nHKZ2ASnCY6Srp0Ks4Z2unC1eQ1jxKPbmklwFnC8mSayhaEYOROp8sc1Wu9mNy73tr8Cu2uZNLoYiE+VTN5lP99S4ZHTjiS8WxNOo+5YGceNiUzUed2rbtVbL8E3OuGa9FJsjDvu/VpQ8VnI/02/ki4I8b1zDb1z9BlWEnZ1DP019NtEBf/rVIaaD0DVdVDaAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uW0pP5NhNm3AJXQZIrhaybGJp/hv6IH9UgIkICUD+M=;
 b=O2n+y7Q632LbrlXatxf2gUPTdZoDcaOjSNF372XYVBpf0hOye5tPrTrVZDQ4fDQ/tPd5BzbsUEcbY38TNibfywWWPPZI7/Tzyu9G91S4POU6yTwv0vN7xnjHjsXHmGHeBEayFzafK6yFN/qZoHR5YOHXsOQ6pFwKrrINmVFrYgw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13)
 by AM6PR04MB4854.eurprd04.prod.outlook.com (2603:10a6:20b:e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 14 Jul
 2020 07:52:43 +0000
Received: from AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694]) by AM6PR04MB5623.eurprd04.prod.outlook.com
 ([fe80::ccb9:b047:d156:2694%5]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 07:52:43 +0000
From:   Clark Wang <xiaoning.wang@nxp.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Some bug fix for lpspi
Date:   Tue, 14 Jul 2020 15:52:46 +0800
Message-Id: <20200714075251.12777-1-xiaoning.wang@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR0401CA0013.apcprd04.prod.outlook.com
 (2603:1096:3:1::23) To AM6PR04MB5623.eurprd04.prod.outlook.com
 (2603:10a6:20b:a9::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.71) by SG2PR0401CA0013.apcprd04.prod.outlook.com (2603:1096:3:1::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Tue, 14 Jul 2020 07:52:41 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1663066b-cb78-4241-8c5a-08d827cae35e
X-MS-TrafficTypeDiagnostic: AM6PR04MB4854:
X-Microsoft-Antispam-PRVS: <AM6PR04MB4854ECF036231CC022CAB5CCF3610@AM6PR04MB4854.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IdzoYxNfddOVQ/4r4l1bhxUJ6GK+8AEml9Hnpb30qyGZELN8S+uATRqmYpRnUlWAUbWNvRZPC/NdiJ/SR5otz7UllogZpteYzTyMc4xR2nlL57JaPZvTNYpRK0vjbvEe5Sazh9xNCXiqhqINCE87cLis/CTv7zrKG6dX6CZTnwoD9Pw3vRzp0V2eNAs5wqoIs8PBcMGfdnaz/ianIdwWcRO4y08immoVf8SbMNBjc6YGjZyvbJ2vR8iZxb3+8FM+TImkNGyBUQ8Oj0soYiucP6KLcfSKL4GVkDZswlFSejP8OplvwF6FdFcMshC2zVRM3HJP6NkErXc/oAulNVf9WZdpiJ+gvdcF6bZs9TqeLRKd2vNpoLkA/w1s89Vnp8ux
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5623.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(66556008)(8936002)(66476007)(66946007)(86362001)(316002)(69590400007)(52116002)(5660300002)(6916009)(83380400001)(8676002)(2616005)(956004)(36756003)(4744005)(6486002)(26005)(1076003)(6512007)(478600001)(2906002)(4326008)(16526019)(6506007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JIYp48Ayh5kAxwvF6DUaXggsl3BMKTrwj2RENwmeRRarNu+wnDbm/5RkJ23BhG6f/WAc3fDQEetqz3JxB1DgmKxJRQo9zTvFyEZmSjOQElP+lb6uGejGzdl32bKbSx703eGlIIDyuO/ljtp2NCuCdAAJxoiBIEDMTwM32m4SgyY4Q2DgQMdzAoKe3aL4zErL+XOLqs6gAt8oeVjzwEqSNO5HU117inQmkf4oUSgu7v5yuasHuzeEtUCM+19hEoIt/9pfkXt+7e6WyDZ4vaHdrHg1pC5q+GpUHfuLb+4HPwn5xyJKJ4DNrBQJ0sd4LycL5ubAfOz19updxgti3TisQG0y41YMf1nRZalVTGIR9vG9vuhEVmdcdSsQB2igqsRr7reC3Y5vY5UpHB8c5Nf993PyVeY7H72b+R+WorXvlMSvzXfJOEslYKaA5hO3Z99/Qq1RMzkUTbTsF5Amn399DOWJhX54HAq8nME3NOy/3r4=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1663066b-cb78-4241-8c5a-08d827cae35e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5623.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 07:52:43.1882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jESqOce/KM3jcG6sF+KtyfjONegemvqsGg+H4HWe4857s7JGdlOAqyW1qevNlP6UR8ZcFZMyA+oeyEOZ1kMqkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4854
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

This series mainly fixes some recently discovered problems about CS for
LPSPI module.

And two patches to improve the reliability of the driver.

Regards,
Clark

Clark Wang (4):
  spi: lpspi: fix the imbalance of runtime pm function call
  spi: lpspi: add NULL check when probe device
  spi: lpspi: fix kernel warning dump when probe fail after calling
    spi_register
  spi: lpspi: fix using CS discontinuously on i.MX8DXLEVK

Fabrice Goucem (1):
  spi: lpspi: handle EPROBE_DEFER when get cs-gpios number

 drivers/spi/spi-fsl-lpspi.c | 52 +++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 11 deletions(-)

-- 
2.17.1

