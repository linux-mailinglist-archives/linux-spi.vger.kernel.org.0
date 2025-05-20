Return-Path: <linux-spi+bounces-8220-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4CFABD7F6
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 14:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4B93A6304
	for <lists+linux-spi@lfdr.de>; Tue, 20 May 2025 12:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808D327AC30;
	Tue, 20 May 2025 12:06:42 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9FA14F9FB;
	Tue, 20 May 2025 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742802; cv=none; b=mp5bCzQREUhhwaoelQhPPdbHupWuYXwGFYLsLFvBlOLyJJKeqWNFysQXcSDKjoKvQKEGMujnn5SfTEYXsDw44KxtUuwF5KA5PN7jpVmWSURuHfucGXhMVyqG9QGSSRTsuMcap//bE3s1woaEO92ZIdz27/C3ewMzEp3jukcAwKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742802; c=relaxed/simple;
	bh=QB4woBeehsgVS80OXDYO14NGhGjOwiQ0uBVYCKGpkjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UBdMBdFixKi9qfvt/55rSd1syB8aOWUox7z1EyQeKLLTDPojrf5+MLMZfU7RVJjFIaCIsO+o11eYVPxqBCptTIrkOxIDB+Jmw0m84R+NnSra6wzoVv3FuagNVpTt1b2RLYmD9mSyAic3MlL09cM+BBwGcv9/q9DwRLkz4iHnB84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c04:7a30:290:8105:3706:5628])
	by smtp.qiye.163.com (Hmail) with ESMTP id 15bc46b45;
	Tue, 20 May 2025 20:01:26 +0800 (GMT+08:00)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: jonas@kwiboo.se
Cc: amadeus@jmu.edu.cn,
	broonie@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	krzk+dt@kernel.org,
	ziyao@disroot.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add spi nodes for RK3528
Date: Tue, 20 May 2025 20:01:18 +0800
Message-Id: <20250520120118.1246479-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <28b03818-0290-412a-8d1e-9b88a163d387@kwiboo.se>
References: <28b03818-0290-412a-8d1e-9b88a163d387@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaQ0lOVk8aS09CHksYQxgYSlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtPQUwaSEtBSUJLQUNKS05BSExLTUFOTUlDWVdZFhoPEh
	UdFFlBWU9LSFVKS0hKTkxOVUpLS1VKQktLWQY+
X-HM-Tid: 0a96ed91f06c03a2kunmccf6e257ad0b5
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ngw6MAw4HTE6HBpCCkNMDz4i
	MVEaCSpVSlVKTE9MTE9JT0NMTUtOVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS09BTBpIS0FJQktBQ0pLTkFITEtNQU5NSUNZV1kIAVlBSklCTDcG

Hi,

> This is missing power-domains after "rockchip: Add power controller
> support for RK3528" [1], spi0 depend on pclk_rkvenc_root:
>
> 	power-domains = <&power RK3528_PD_RKVENC>;

> Same here, spi1 depend on pclk_vpu_root:
>
> 	power-domains = <&power RK3528_PD_VPU>;
>
> [1] https://lore.kernel.org/r/20250518220707.669515-1-jonas@kwiboo.se

Thanks for the reminder, I didn't notice this.
If the power-domains patches gets merged I'll add it.

Thanks,
Chukun

--
2.25.1


