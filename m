Return-Path: <linux-spi+bounces-3328-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6378FE851
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 16:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF299287C25
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 14:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F0D195B34;
	Thu,  6 Jun 2024 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="xWq+0p0E"
X-Original-To: linux-spi@vger.kernel.org
Received: from repost01.tmes.trendmicro.eu (repost01.tmes.trendmicro.eu [18.185.115.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D761953A2
	for <linux-spi@vger.kernel.org>; Thu,  6 Jun 2024 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682572; cv=fail; b=HGyB9lNlGyqu02t6ws8qjhIfWbSkERlo4MAdNqF8F4I3jfSj+g4ldAH+Ncoxi+4cXhe8TkUtb0CvaabI+HzGihdXMZVGWz1Bo72YeHcI7xQMtUIZlJUTRF/sroCE2OGEHBQ9EXHMI0uq6dIaZp852FIMD03ZEuTVbQhyITMeF5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682572; c=relaxed/simple;
	bh=XHURqw/fyGE0KeVFuGEPUmfGHgf6mtgOUOgN7fBdpl8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=r24EC7Hf5xfVrzmkxpRGMbO/6DjVHdrg4uTq/NcnmItAQ8qjT8zCN681MtCCTLJVFLmpiIb33DohXoD+VbJYPIhHQhEOb0FS/aLtWvqKiICYFdSMVo5UBp+REr5Bj6e8hxRYo6q/nP1tYv1/ZGyaQf9Ta1jTZ6Fhir7JE0Lrhpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=xWq+0p0E; arc=fail smtp.client-ip=18.185.115.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.172_.trendmicro.com (unknown [172.21.191.80])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 9CB4710000D1D;
	Thu,  6 Jun 2024 14:02:42 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1717682562.100000
X-TM-MAIL-UUID: e47098de-c7f3-4931-a70c-0e2d1883a59b
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.172])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 188F91000040E;
	Thu,  6 Jun 2024 14:02:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luc0RIDepMsxl8tRusYDCZE3KUBiZsldwM8oQQ+V/v9uJeM5PGe2pS0i6D2XFJMhsHN34hTRgmdbMrQXJk/1ysd5jjKZAAljWw5BDdSEfoCQozaB5oAxKWQPqS0lR9+QZFRu59qYXIQH2gHsq0sy7pwzRXsyc5HBjbN+eYBavkvpGi3bT6dpLwBxXefFmH0/UPpMjuj93UyqPMYw7ejbalkj4ZrivgNjFCsbPuc2yxvlpPNJyyEdVwmm2guVnD/sWLMEXkK3VQaNX3pzhd1jouE/G0uuzHiWLVAPKwqW1EqZ+ICLx6s7uMlp/t20j6h3ZAmSK/5CJlwvvAYIzbPaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHURqw/fyGE0KeVFuGEPUmfGHgf6mtgOUOgN7fBdpl8=;
 b=N3rFn8gjhh2EDp1xWTbYwW8pMMkzY3z52PkrRnbk5vFXQnHFjeGRKN25xmLwWD2OAztke7EQaAuloag3wcf8EfF54nllJFwnprMxLENn0N+uVtwlQHh2ukISASIP6HmweUG9R2ny8i/d66A0qexQQx0iKZvMlkFIZvg3VZ1G61+YAKNz0Dkke0AWg1OfsrMNfiuufEMDQrAWII7tkG/wd8lkGPxbH9naGIJcAYhGvIWZfMPi9OPtH8UI9eyq0k1cdJKY5U63LypEVsVycq2cOJQyRjLaMLGIfaKMNx3KrzOpE6Rs9KmvUA16/05WjXquO8/3G/54FoM1Nz764C0Wtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 213.61.166.92) smtp.rcpttodomain=kernel.org smtp.mailfrom=opensynergy.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensynergy.com; dkim=none (message not signed); arc=none (0)
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 213.61.166.92)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensynergy.com;
Received-SPF: Fail (protection.outlook.com: domain of opensynergy.com does not
 designate 213.61.166.92 as permitted sender) receiver=protection.outlook.com;
 client-ip=213.61.166.92; helo=SR-MAIL-03.open-synergy.com;
From: Harald Mommer <Harald.Mommer@opensynergy.com>
To: virtio-dev@lists.oasis-open.org,
	Haixu Cui <quic_haixcui@quicinc.com>,
	Mark Brown <broonie@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: [PATCH v1 1/1] virtio-can: Add link to CAN specification from ISO.
Date: Thu,  6 Jun 2024 16:02:27 +0200
Message-Id: <20240606140228.10154-1-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5E:EE_|FR2P281MB2331:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3d55aa85-f699-4abb-a329-08dc8631540d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DlfhiXVKVslBDaLdpGFuYQmh3Z5k0liyu667ejVqENYNji4HqGbPcIhfqXAJ?=
 =?us-ascii?Q?wLHa+JnHnbQl6Oz6LV3ZeFZqcWQjkqJoWVhXmPerBlim8AMwY+jxn1XV1ADa?=
 =?us-ascii?Q?s5hNJahUJzhMDDF7PIjkar3UrY8j5L8a2w8wDgKQxVCvFfbYMHZxGcdCdOk8?=
 =?us-ascii?Q?+t5/FEirg3O4THB+V+ZltEeh+fF8+mQW2QwBunExSOtgpBTaSO3ViAqls94E?=
 =?us-ascii?Q?Q08RfB0MYdLwHEjXUTmpJiCVRpthWwlRb8e794BNQbEt3I599tHpJMzm+sja?=
 =?us-ascii?Q?daWqQwVn21fmL9E0yRQUXjv/zkeks0w0cerpOitLEAAVSWGCAx7wBEFmKCWo?=
 =?us-ascii?Q?UWEn5DV+7Nq7jGcVXFnbNBrQdyDZ2LcCh7WjwzfFFu7z8BrOu6dNXZFvqlMA?=
 =?us-ascii?Q?WvnmOG9YBLN62x2eJmurLLRHitM5WWLOFco8A6eBpq4qiiw9Y6vQC67eW/Wk?=
 =?us-ascii?Q?Aj3t2y5b46nPcrZ6nnpRVjZ8mhe1iB1YZKRqy/Hd0Lk744mXVwePReTWyOaX?=
 =?us-ascii?Q?bF3r3kU4r0sINF4G4XXtJmRdzFix2apc9GvnAwOBrwJ0k8nKz1G+LIZ/CqpK?=
 =?us-ascii?Q?fW7ktB03Ki+8D294l7VXdi5r+ZUJsvLDW59BqYQNruzFKqf9rRNI0ISke3vo?=
 =?us-ascii?Q?1fmVzHJtlu2aKoHuIScOjifhyg7yMx/G17KQ96KGkKClE1HyHCAFdFSK0AlR?=
 =?us-ascii?Q?Ob2gjykV6nXeH6MNqZwrgMCUrSDf6S3DvsEKgpXsPIG0KWkkIE510a7a4PpO?=
 =?us-ascii?Q?tMAfSM3B5vnUQ+wVp1wRM/6SSt9tXb8s7AAjmxTLpCUjzYCceUxrQwRZYtYD?=
 =?us-ascii?Q?U359oO94Z+TjX4wsEIOW+h7SNWCGRvAMJwDYWUILzpYLCebrXxcyCSX4s1LQ?=
 =?us-ascii?Q?XnK1kjwa0f9wAIvUuzPw4hFP4E+6ctdmBiiSZIZ1cgqGtD5OSLITXPP57bfW?=
 =?us-ascii?Q?VZ3XjaJCeOMSntdCmPzbJEJpaKtHUwd8J8uDa3YRgefahow72gNvfPml1Tmk?=
 =?us-ascii?Q?DkTVBRSOCpXUlOZPDp5SnlBbhhJp8ADT6X0yEKbQTn+j2PZI+zAzBA/cWxuw?=
 =?us-ascii?Q?MWR03O22hrq15yVLc2csZjRrFhQQI6mNH2zKhvC1AuSjlm2PxYwPMghhU4We?=
 =?us-ascii?Q?CA95dWZ/xmcgQ1UxV7Gz8RpVKS84QmqsMdYU5rarst/gcIpE7IpI3io4c7wD?=
 =?us-ascii?Q?vC/dxp4lSzk99YIBoc0jv9SC2BuCcI0GBImSqW6ChmB6DJyjKuindL6xdZ85?=
 =?us-ascii?Q?7kXmcz7Vsl95/SJxOn/vFPuV7lZ4kSTqIVXLkSjdoyVP3S61nxqKgRl490Cc?=
 =?us-ascii?Q?Bup6Bb8SmktTC4fA2Ux2wuOi3XtQ3QxLRvmB7i/BZ+Wxc41zQucZH2MK4oSn?=
 =?us-ascii?Q?nL3MmyxWsNaQ4YG4AjbMwCnuQB1/DOYuzu1I/scoxwNt6zYfyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:213.61.166.92;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:exchangeconnector.opensynergy.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:02:40.0842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d55aa85-f699-4abb-a329-08dc8631540d
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[213.61.166.92];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB2331
X-TM-AS-ERS: 104.47.7.172-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1023-28436.000
X-TMASE-Result: 10-3.302400-4.000000
X-TMASE-MatchedRID: RtHHqK+8YWPtZDpZlNWg4O3qPLdU3cUZj0WS9qqnzG1SMzx3ql2YQ8yf
	xQnKP1ktupoogdfVK+Jd4x1IUlKnFHtXApm0iq5BW8gh3wzbqBNc6J3HmdvsScjIhoHJUA2GjeD
	+F5LMZVf4gWnCwMJgoFo7GmCOJYd13+6k97GsyDgxO3/MhcmPdTwJL7fndtWLy3ztgcrfeg1rEX
	qURa+VlfAUuGv8Jxx0
X-TMASE-XGENCLOUD: ea62a29b-c247-4535-b04e-ebebff89ea26-0-0-200-0
X-TM-Deliver-Signature: 0EB464EC2B0F6336392C3DD81FCE23BF
X-TM-Addin-Auth: q5mgkpdJWx/3F7Hcj2nIyY4ALKXsDJa0PwIDxjnRFN5dYKAbcA8/LHdnLoO
	e5DBkhUSXNbFTZq0T46MrVztjhqE1T8DWrhUHlFCCIi5CyvNDs+1xgXcgF3GAdqwSW3dxxm1M+v
	ZBTxFoCMNBWFwuDI1CptKRlO4GZEfdYqYJH7QzD3Es7jsk2GKsWy6wllu9oDh1zUoiwhk4z1fiu
	R9DvVaGRU0VT8euNRa01QOhQotkescBC8QkTnBCjeEMSXvkWh75JDAwWZYezsPOzZGzVLayZdEl
	09lNWEmd9RkTE2A=.kxKnfaTDJCXrM+wUw+bJ3wr/ab0ZuwS2qcTR3jOpDLxEBRVq4FpsHleWUH
	vukkTqCnJODwU1M+GP7mVK8l9Mv/jIY0fzSZscdyLq3aOY27rfIzpGfhr1Jvp0u0+tix75g/MST
	weKnNSGJJ/r1px7526digehbbs2WaGERVSGQeVTaLST+/Efek7TD5T2ZS/dD8CQ8SRfjHF1MqSv
	EYcpQWju5c8OEegyhUkY/nwYb9FslFeObidSFXNXM9dvdBMQG8oW8vhvSww8Hg6yabZ/fdDwKY1
	dbtGVAngzktAW8nJVdAqA+dlahXtVjCc68uts9TjbqajXxXr/8v0MWF400g==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1717682562;
	bh=XHURqw/fyGE0KeVFuGEPUmfGHgf6mtgOUOgN7fBdpl8=; l=286;
	h=From:To:Date;
	b=xWq+0p0Embn2wQfs9Bfcgmi5oVFhA5L7N0I7DT7DdFsU4aHXkt+tYCSLWQZ+MbtTV
	 mOUpEEWV9FkZ7B9d+hRxn+hiueUeU6KCqFM2mUi0BcEaoz1oPnQdB2Okxev42BjqhA
	 5ZM+3b69zVupwewq3XloTuQ72LKu0YEw6Xh8lUKgk6QH2F2P5VwRyXTMNRcZpzhjuM
	 NxGpqo+7CrpSzBjWLU0XnKxOsSYGTccNLJgvZx7XdkKAHLPLLPLZArQrliBweePg7e
	 0J+RUM99gpDWGo1Xf+hs+7pkYh6UDD+YRULy9Kcl3Hi3VbfcpN47zsR9X1bo7ENWdg
	 tNjyRviA0+7vQ==

The following editorial patch adds a link to the CAN specification from
ISO. Even if the specification has been withdrawn in the meantime in
favor of a newer one from 2024 this is the link to the specification
which has been used during development of the virtio CAN specification.


