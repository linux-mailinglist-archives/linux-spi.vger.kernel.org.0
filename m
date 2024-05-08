Return-Path: <linux-spi+bounces-2769-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 570D78BF603
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 08:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0B8D1F23469
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2024 06:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068BC17C79;
	Wed,  8 May 2024 06:20:31 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2115.outbound.protection.partner.outlook.cn [139.219.146.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A481758E;
	Wed,  8 May 2024 06:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715149230; cv=fail; b=biqB05ROkAxJaemQcHrv5n67k5V4icl5zgA+gbvzkZ16GlHxXVfv6+AVlmVrlG3CDShEq/bgt5Fj5sWLSUr4QbAnO+3grTTqjE+ZESJ7FeZBa7b7qT5n9dmB8WKYOFKqVaxDhdBfLKVlqaiZQWsiu2KTnMMJUZb2ZMRMJ4jLEc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715149230; c=relaxed/simple;
	bh=rdPUtQ675hwgNMI/PlmKfSzLCZ/j1fNA27U4VrYGgzw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=icpY4LTt1XIq4gFVS3SjuxxQzk11xrcqFxIsEvxWmwtjV1s5EHOccrp3mW8yJVH58pjjrrvMuyqPnFTvWYACtRO6TiAqckHFKPBggWMLLNlI9VIxvtiUiQLbkWjBNP7qhtPlM0XMDduE/PMf0LwEFf3coa5egKgmsiOTIJ941EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czGbGrJQ0Hcw0k6GcDeV4mq8p+jRXq5lJnPqmECJZIu16oeimVGJ9GKYeq1TfwZe9nO+UmTVnaWfMwCgX6sqKudNwoeerIXSuV55CTeoVQzU2muH42vgr0b5vlZ4w1zKQI4jbO5+RPvR/+2snV85QlJmqu/TPODNqZj7Ta0jthKbn4Ki1EFclKZV1vwK+137gSzDLkhyk/vMJgupi0c/0nFRC5LJWVVP3HXwYAgIxJpefn3y30i6N6qL2yVHYOJ/fFlK0HRKN9KrODyZ052gPDlOCFtO3uCjWb4Ne/0lAhCNDFcmLz2/kSQvwi1Ql4StSo6JyM3OKEHK1wbVrRzIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDYhACnrixQIhjb1jRKxRA3HQkg0g0CEvUI0w+vAtvU=;
 b=GIm3zcLoB/7nmW+rkI6QqgnVOq87OsR8tP/r4BPgbVuWKZGq4T2ZFEPPdbHEERHub5ynG0v1IejWvYs/7TceaQxwjsNlJ7jVkaw/7/FyBkofbP85+IdcRgFNNB7gzL/Hqq3d6d5Yx3kS4F1J9t1nV6nKMWPoA4k2ZnwMdloyuPyQ86wGNTSJmy2eQli7w654+JkLYX6GcMg+yxStKSHoYARoP0qKNUtqlr2CKdfOB6KqvFd3i7vbwsHvrKUWdoi9GgMlOt4vnltkNRXb8wTGPtuH0pGmiQb9bzvXFKvRds7nw1e8DEKtWT75gVcIwAlQo1GKptFY0zNjW0nrMgWlrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9) by ZQ4PR01MB1283.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:15::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 8 May
 2024 05:48:03 +0000
Received: from ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 ([fe80::301e:ec80:4356:8b14]) by
 ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn ([fe80::301e:ec80:4356:8b14%6])
 with mapi id 15.20.7472.044; Wed, 8 May 2024 05:48:03 +0000
From: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <michal.simek@amd.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Add optional reset control for Cadence SPI
Date: Wed,  8 May 2024 13:47:26 +0800
Message-ID: <20240508054728.1751162-1-jisheng.teoh@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0026.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::35) To ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:17::9)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ4PR01MB1154:EE_|ZQ4PR01MB1283:EE_
X-MS-Office365-Filtering-Correlation-Id: e55a6e1d-9442-437d-6c34-08dc6f226d6b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gGP6A6hgS+BxkSlaIQa6ROj704vWC6OFtJpgJFmF3PG/mUw0uRs5aqkB28guc7tnJcpSytn8D42ID1k3LKGqsgfsJBfrVrr7LXZ62Tr8RA4lpUwjEG6lkKIEVK3KZEiery5woK0WackmBKNxoXyKjuZrMJuKnkpcn1CupuhaNtv8U7cHfaImr+WsS+s16VvV+8qBXEZ33Q3cS/uS2wFnJMMl1cRyP1Mq5u2m9l/ipz/ORDR5sc4EIueb2nGrA/5fMEwmLTMdZbLHSYYhVOPMbibcJ+odvKPZ/dWBYch6dUi4oKY8LtnE2ZtJFvwkAYQdie/7Fsxef0YoBhwJdzV6xcOCuSpILzRk6mx4dv5dcImw9ujZUw9PhHHBb78tc5aZ3iQ2xdIOf51V3R13bit1DR9B6cOb3iDD0wxAISZ6EGsoPxrlf7VXaOOuMTuMv1Da3AyLO9oP/vIokbsfucz7ichhd4kyKhLq/KwV8CYUwbtAbMdhjv9uZU+SePVPBzy7fHEU3J+7T8bJrauU1+qmR87MQEoAr3Bh0CJ5zfFhWc1k+n7/smDWEjX04p333CbsegCBUzyj9rnveLw7xHl46LNJTT/y5e6XMy//Vyl8217IKstzCbCUFU8u/dfMW6fT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(41320700004)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1dUJBzMBlYkl6qxV5mfeOgp/C07wnFTaCpawPsdWGhgTVUoUMrSOFurBoLvQ?=
 =?us-ascii?Q?VUJxLVcPx7FHJLfXg5Q5KqNqSaHrttmoMumilGwCQV4KoJ+y1+yw/tvwi+5T?=
 =?us-ascii?Q?GqXneX3SlcyY6sWVU5xShAayB/5GXN3QnWWsQnlJQJ4yF2lMeye6EQfr7uBv?=
 =?us-ascii?Q?MxQCfkG7mdbv0ed3sNR5sqjzo0C216Zp73kbGnt03uFkNkA7C4jvCSWzjfJY?=
 =?us-ascii?Q?PfgVxPagQK99PayVartypS/P2VphVugWnSw1y9LZ5odOBqkm4tvLl+HdHGHI?=
 =?us-ascii?Q?Qh54TfAnlzxclahfuXIm65DLEyFq6HZykztpdfWc5UdkY92fDvD8LsmbxmlN?=
 =?us-ascii?Q?kQ1kBaYE2hkW8cCIex0Fhyi/7B1sfEQvknqqSLS2D/2q9XcoiNVtzsG+5Bji?=
 =?us-ascii?Q?a3jWEPuRc4I2hSMvkpmfQ6+NG/SrzoZtiV9udTmqvhVhfipAt7djEoODKrBx?=
 =?us-ascii?Q?4LDWRWqBNl00nUqmS1icgZj7bMe0xD7r/QkNk1m0vfVZjR2exlbj9qfenpaB?=
 =?us-ascii?Q?nn/JKy2BzDmq5QU/mmfLzbQ7xwgUwq9GA0wxCm5wsPysG13EgAvkNj1M0x/G?=
 =?us-ascii?Q?UfKZTBZagKfgsh643jhR87HvjSH0EXjnhmpWjgNtnR9uh8cB44U4+KL9Tq84?=
 =?us-ascii?Q?omALXB30ykOlzNoSOYXPPGmSLaAnDxyJwTfVFqD5i9fGD5yafhKGCfGGnAK3?=
 =?us-ascii?Q?KS2Ud/FaWLWjCiR+nlUJVz/rmMZVD7unVFbbtR3OYPd4hwB2hY84fd37dg5R?=
 =?us-ascii?Q?bUFR0tw04lmlQJ2VD7ghWMRcKp7AhzNcRQfSh8amH3iaxFFdLewV7SdBqfDh?=
 =?us-ascii?Q?4hr9V9uidWDHoC2y/TPe71bH9wE0HWYsWc1gZC/4QzVfNWebW2uFUPNbJkpK?=
 =?us-ascii?Q?tWkL2fCq79A8Cbgml5rKSYk4TxaUh9C1iZL5iwIedYDJhRzpg1kHTM5Rfdqn?=
 =?us-ascii?Q?IaHvtXqEk6XtwJo4qPMMV3nCdj0czJ5fYGKCDDaiQHOhMn49yHH09gsrJ/Hc?=
 =?us-ascii?Q?IVgV8OwDdD975cw/XjtXSDa+1A1OXbfylw4FAcika2FSMBiY80m/rjZNSct+?=
 =?us-ascii?Q?clSqzKS7s1NKhYckDSWIYo46px2bBtprvOEfA6SDjgW6reKxnUlZmwLY5Z3h?=
 =?us-ascii?Q?txnmLEGDyUYG5E004psDYObePbzouKLqXRUjwBAqhouBGeBBgHM8HwMKhtD2?=
 =?us-ascii?Q?MFgjBInOT9RmnGmvkOnWPB3QNO1Bki2MFlUnvPFsYNHQKuXNepveENgNn2MD?=
 =?us-ascii?Q?2YScIPlRJ6lPdaHwRTm3LDh5ivN3XKtD8kDgc2ql0V/u1GZQxhxSEs5Deej9?=
 =?us-ascii?Q?/rOsVW8+yLUiCS6eJEAqc8se1NQDFUi9EvyN56X++M76mWau7Wniuy8kOhob?=
 =?us-ascii?Q?V0dvxPOSHp0ESIBe9rb+4RZavGtDr/qC857HEgV5d+DhKaMC2wPSSoWLBnR7?=
 =?us-ascii?Q?a/VxChFzlt9D91GdQ7mIl4V+2hS7L3bANoZCbN0p8augsQrbfKfzFx2Ejya/?=
 =?us-ascii?Q?UY95SMwy074kxDuvGTQEQwwW/6iTIUhZOEuNHLeliOrfWpfNQI/N9qe65ja4?=
 =?us-ascii?Q?xoOrWNIsbz+W07TY4oix/6H2uVIa+lKP+mP/4b8vs/UN4WN/DQgUTBDe1F8S?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55a6e1d-9442-437d-6c34-08dc6f226d6b
X-MS-Exchange-CrossTenant-AuthSource: ZQ4PR01MB1154.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 05:48:03.6910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ioo0GluzSeHcJjQp8WekyUGXwaCBcZLz5YjmO+TKrQtFY4xHcvzOVOqkfIgPWjrxKhO525JVI2oCc8JiXoE1KjPbWEcO0eCc46wxDMbH/6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ4PR01MB1283

The first patch adds optional reset control to support assertion and
deassertion of reset signal to properly bring the SPI device into an
operating condition.
The second patch documents the optional reset control into dt-bindings.

Changes since v2:
 - Added Krzysztof's Reviewed-by tag and fixup Co-developed-by tag in dt-bindings patch.
 - Used dev_err_probe() in place of dev_err() in spi-cadence.c.

Changes since v1:
 - Dropped resets description and added reset-names property in dt-bindings.
 - Specified "spi" as reset control name instead of using NULL in
   devm_reset_control_get_optional_exclusive().
 - Included reset.h in spi-cadence.c missing in v1.

Ji Sheng Teoh (2):
  spi: spi-cadence: Add optional reset control support
  dt-bindings: spi: spi-cadence: Add optional reset control

 .../devicetree/bindings/spi/spi-cadence.yaml        |  7 +++++++
 drivers/spi/spi-cadence.c                           | 13 +++++++++++++
 2 files changed, 20 insertions(+)

-- 
2.43.2


