Return-Path: <linux-spi+bounces-3329-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B638FE85C
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 16:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31BE5283127
	for <lists+linux-spi@lfdr.de>; Thu,  6 Jun 2024 14:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FF3195FC6;
	Thu,  6 Jun 2024 14:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="TBr2ZRTZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from refb01.tmes.trendmicro.eu (refb01.tmes.trendmicro.eu [18.185.115.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ADE195B08
	for <linux-spi@vger.kernel.org>; Thu,  6 Jun 2024 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682724; cv=fail; b=kCw/pqfrl1i9JpaaSV67HQ90I/KiBqxt6VOpPM3Ajm/4q5drG7+a3HOsKl0JMU+pQ8YCtjw2kfsBp4CO3E+Ii647KA63JMjozE+MRTnA9egImQLDxdWiJY/DdvI/V/HlKtzZSMhjmTyVnqoZvIeAFiydAdOXg89qu1nscTjyezY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682724; c=relaxed/simple;
	bh=ZXv35xifz+hJm716XeIMbGKw4efsIvlgMuhBrLoADbc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JyBnFKBPaGQrrd2LXwO2VjhsnWxMgwGHq8pXNpjItxzy4FA3xJtR4A/TNx32+9aEM80cGi+5NlJX0KQf0YdnAhVKIr1ij7XpcaanhM8n2uGxAEx4EzS4b/ku1Q9Mg87kzbHHAXJUiTuC1ZR5z4dU1zJq4C7PF7X1o9A8lKyY7Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=TBr2ZRTZ; arc=fail smtp.client-ip=18.185.115.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Received: from 104.47.7.172_.trendmicro.com (unknown [172.21.19.198])
	by refb01.tmes.trendmicro.eu (Postfix) with ESMTPS id 55120101569F7
	for <linux-spi@vger.kernel.org>; Thu,  6 Jun 2024 14:02:51 +0000 (UTC)
Received: from 104.47.7.172_.trendmicro.com (unknown [172.21.181.109])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 044EC10000C50;
	Thu,  6 Jun 2024 14:02:44 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1717682561.432000
X-TM-MAIL-UUID: e0beb38d-35a0-4371-94b0-aa906b2dd126
Received: from DEU01-BE0-obe.outbound.protection.outlook.com (unknown [104.47.7.172])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id 6B5BB10006A5E;
	Thu,  6 Jun 2024 14:02:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iA/itEZHJ+3s5ajfU8Mh+1KW1YvbTimvQmYFNHfQ21fNS6BV08oQh7zEsa6BSukzijVl4OMKNDaNXYrOUHuf4FnKgEm1q15rTWwtgoutGnaoKkRjwPvEre72KP1rUZbUg4XgxXXTtXJOxI5oUeoyQO0fLrrCTphdFlh5Kl0zxZQg83bhzdqVBOwp2e/ojZS7MfLr3FOw+ZXjBcNmFohfmzSAlzYXbGZDnKWIU1ltgiE+PKNN6LtsM6FLKXp++ULEZxBa2LGYil3tx+SHHRua1fH3dIbgTGQS03QzKz86H+rIrdvCef3koLQX0wHxYyp8ZrEN9Cg8rEY+ntzYktnSXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nu7ix7PCGKEAqZGthDLNSCsfM/y6b3m/vUkfP75TGQ=;
 b=M/nHcJl0T8F/1yOU1+I45i56e2QwReq3OeTSoMFGcqnMlcd+YTX6AxbLkpc2CgM5Ba0AaYY1lkpuZfDqiumfMVVeL90LRVEDxNWK9GFCivuLTL4noEwIcDbh3axnsZkTt+Si58lhAn+LaFUYPiwHcrLeUzG6LohPGtTc6pFNXjVwKWcukjY84ND7iAo1JBDuwVozBxFuCOLLIH5JQAzpMXU5JQbTqPhI9N1ir8buNQSIUKZzIon34GCoShVY2q6hpUkPRRT6QRBirqr6pkaItZj5JGOsfe6V0nMsFRQlrGYt3FFeTTrtCPLcx2hhUMttqegj46/c8htLzAETJaMgBA==
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
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>,
	Harald Mommer <Harald.Mommer@opensynergy.com>
Subject: [PATCH v1 1/1] virtio-can: Add link to CAN specification from ISO.
Date: Thu,  6 Jun 2024 16:02:28 +0200
Message-Id: <20240606140228.10154-2-Harald.Mommer@opensynergy.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606140228.10154-1-Harald.Mommer@opensynergy.com>
References: <20240606140228.10154-1-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F98:EE_|BE0P281MB0130:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5024cda5-2fb7-4b98-0c91-08dc863153db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8f0YKe0vsmjt8J30kiFyQZm4B3tu0p0gahcktpWk9GAWP/n8+weazkzREBTY?=
 =?us-ascii?Q?jamHJSBpalntNb0jPn8fFYtCHuUzRu4I9kwg0rYXPEhwsvkezES/8JUjymKo?=
 =?us-ascii?Q?Am57T05ScghXPmxV6nLleGCzLirITL8Yymr7i71PxE867g8Jl7eSZctykWcX?=
 =?us-ascii?Q?68WJeY++/NpiB75sXWi2i7GnxKEFCQ9UTUSBc6wRMo3RjA+mzXs/EVtw5vSX?=
 =?us-ascii?Q?6qBtAIHvSI8rn5dqq1Y0gGQTDJvlS8UMTdtpP0On3TTKsK2ujYo/qPnI6NEg?=
 =?us-ascii?Q?m6NBX7cg7zwK3bLL0wsup3RsIfNE5F1cnCPVlrEU3nLSnrIu1hTMee8C6c4/?=
 =?us-ascii?Q?FnjqnWBsLSCHY/0rsLD6chsNcMvss6DuPKXVoiwyRX1C9YBaEhmfXXuZfTPD?=
 =?us-ascii?Q?DZViTs5w3b9XHL9BEnH+1UtmK0TDWP2ChN6Mp2FUPCBaLpwX+/gWPswgHLUI?=
 =?us-ascii?Q?nOt9yb/GVVLAvgIeBBcKPIo7ZIetv4gxrVwv6GiIxxibGzBP+Tfozq2oDoUK?=
 =?us-ascii?Q?0Ejun+HlAeb/6GQPO//tf8rxyHvGRsUYc87IpqDeevVscvm2UmDv/molHO5l?=
 =?us-ascii?Q?YiBc0ISEoJV+b3wG/xrtRlxZb5Zj7BZBMDdFHyE2rwK75ejCrSP/KhA03gNZ?=
 =?us-ascii?Q?kez2Xat9mdlUWvR/JnDTdnOuiB7xazRG67TfOB2TcZhhvLZqpSndKZSeGPoR?=
 =?us-ascii?Q?/b8uQHSN+ptutLAwRNLnC/UmG+WPP4FWcLZsUahFUu51ryu0FhFYEesfiqfS?=
 =?us-ascii?Q?Ftw/IxPpw3Hlx7sk7TbAKqTPuIebl2qrbfay2nEOxs5g+ETj371EeFqbsIQL?=
 =?us-ascii?Q?7pteX0BPHsrcsE3b3OmUZhijygftO8/A2Q2dJZlIDJyv2aYL5f5jhkyL7Wj+?=
 =?us-ascii?Q?+sErEwlizZpkdwzjmz7K7ZlJvtDudSE4Lj2+XHSjJDqK1VYFryovQcPct4ij?=
 =?us-ascii?Q?OeKiyDb4HpbXy4gCSXmmD+R+za8Wo/Ni6ABKZW6RULdG3cBSSUyJyR65Wrl1?=
 =?us-ascii?Q?uDaRSQtYi5QGdIJzHohI7jfK3OqIUaZEpD8Vk03k8PLUySR83ZFPsR0oVY6h?=
 =?us-ascii?Q?z0VY5vTFYRE4akyY2hqwCjkCUb8XHjQxrmdAoXecCB1QuhQR84iA4tpL/CYi?=
 =?us-ascii?Q?+//dgJNCH+b6PbxX4e6L8tR11lfULu786KBZKhq1WUpPbeZt+4kDcphEBlXx?=
 =?us-ascii?Q?0/tt8sZ/XZKiop1aCkhEXyc4bq/AjCZS1LPYB2lrII11940hkcOkbed+QUfX?=
 =?us-ascii?Q?zaXbDZhvH/zMv1VUZQb4ykUA2W09wUhLtuh8VqeYHET5P5n1DHzRZ2LOisU1?=
 =?us-ascii?Q?GfWGtwACZT3X//QEKeIAXex+I8Xfrt5PorKttcHS2NhCxhHvTDhuJG7+GPzm?=
 =?us-ascii?Q?Yrcy/a8vO+lZPiHAogSwNRPiySS0ES4ve9ueCvSrwh39sPAqdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:213.61.166.92;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:exchangeconnector.opensynergy.com;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 14:02:39.7370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5024cda5-2fb7-4b98-0c91-08dc863153db
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[213.61.166.92];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F98.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0130
X-TM-AS-ERS: 104.47.7.172-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1023-28436.000
X-TMASE-Result: 10-1.047800-4.000000
X-TMASE-MatchedRID: NGDYxnKYxb3J+P2VFrJmrKdMZMc4JlQbCsYnJzXwRoqL12p7cZqBWIvP
	iBq/iW91MpPx8OFzfY1Ta75sGuqeWKi8PTAxIaqS7yR/hLt1y2iFU/rz+g+hxFtpNa0o3mGFqXN
	pl1fc2dczrT87MhOW5dAxdIKEp2hCA3ASNiUtxi2wL+/cgG+7zMn4xfDEuqcVQUZlCPgOIPyF6z
	UvsSpW6rEDulXIfwn2ckkZYKzf3mGfQEixngIIE2B6KL0WmlgVYppqMItbEgOI/kD+1oWNGb/a0
	nd+hIFCI/NGWt0UYPAv8kOye9F0ID8aOpcAGK1zWClmBfZH1l0adwCj1QH6tsX55enpC3hi
X-TMASE-XGENCLOUD: 4fa0bea6-c2da-4c0e-bb59-16aa17661f19-0-0-200-0
X-TM-Deliver-Signature: C6195E559DB6A41E45ABD6A953FA7F46
X-TM-Addin-Auth: Aueiszp46ePTXE7RAlGKNs94Tj92iYafNDA26L2MfDI8YEIkmeSCmob7k2i
	RE4LyQnIimL4nwiVuDuHd3+1u7GtgClx2AB6i7J4Vltf27ZjIWC142jatq9nUQBRyxV0wjBdiYO
	/1GTSrQODNL+LeuZJB+IFxNTvG1Q5zpRgyWetv7oNhEgeQgRiI7iflhUsVYJjfVpHPQpqn9GrDU
	+LmMaUYHJxrkG7NpO3yIcl+bPpwy4/YqJZmQtyuhGZsQSm3/0VBnIM2vgVuV53yEBB0TA0FniUt
	uNppWJrdmIrJQzA=.F1fxJ3gcaw+dZ5BHF2X+Mh0vFe/Wq40j0KVOUT+yIZi+CBHannN0WQiPJ8
	ffnw95x4OLGC7J8eam1lv5LhHnqAPv2KLFlHd2HjKxb7iMsRvGYkksvuTr9IIGit6fTPwpsH5DB
	txlyEmJBXlyDkBuPLaGZxRVWu6LATvNggqqDhYkNxRMJl0dW45dA63KMRnLSbCPdC9DbNJnVVH4
	DRVsJR3RMtlCcCT94aB6+RU1+frAwCHAWBrS/Xag/KjNtqQjn0TsV08jYJSVqFPg5UhRHmq/88R
	GxSj3tdwEl4mA9WCU/ATPEuBbIq1UAoAQLIQrN7DU8+AVbQx1pEqZJUqGSQ==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1717682563;
	bh=ZXv35xifz+hJm716XeIMbGKw4efsIvlgMuhBrLoADbc=; l=1043;
	h=From:To:Date;
	b=TBr2ZRTZ2iX1wuTx6MiZ4rAGOj+24zs82RSfB7eVa8f8njgUtiBZMZw5s1VEwaXAe
	 vPFcEQtCzKvV9KM3+fV7t2MAppNHiEWPcYkjJdw69o6XisBqxnZmgJ78IWvTGHCOyZ
	 a0gPk/snds2Tl4Ct2MnR7kzj7yFY6T3po7ujWhJRcwIJYA1uQk3SXDGiOmhuNM4vZL
	 4mr1aGjGzgI1jEbgBg0CRMEtqp/ZPxRF92Abe1liv9BHbsuEx3Da6lpITnJWFTPhCt
	 ud8svddxoC0qJzsTIXOLPikvMwJZviyUetXS9eEuKDttjkGT5uo+HQnuGcxcXLHOXA
	 oxQ4KNyredElQ==

Add link to the CAN specification in the ISO shop.

  ISO 11898-1:2015
  Road vehicles
  Controller area network (CAN)
  Part 1: Data link layer and physical signalling

The specification is not freely obtainable there.
---
 introduction.tex | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/introduction.tex b/introduction.tex
index 8bcef03..72573d6 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -142,7 +142,8 @@ \section{Normative References}\label{sec:Normative References}
     TRANSMISSION CONTROL PROTOCOL
 	\newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
 	\phantomsection\label{intro:CAN}\textbf{[CAN]} &
-    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling\\
+    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling
+	\newline\url{https://www.iso.org/standard/63648.html}\\
 \end{longtable}
 
 \section{Non-Normative References}
-- 
2.34.1


