Return-Path: <linux-spi+bounces-3849-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B4693012A
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jul 2024 21:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113BC1F23C07
	for <lists+linux-spi@lfdr.de>; Fri, 12 Jul 2024 19:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A6818E1A;
	Fri, 12 Jul 2024 19:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqoWhLAu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E56D224D6
	for <linux-spi@vger.kernel.org>; Fri, 12 Jul 2024 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720814207; cv=none; b=qA7+pW5Luvwbce12CTUer0N321RS+EVjagrDAv5azRbWVuVuNqJ10p6KZqmEvnIe8Re5ZpLP2CUX42Va7cdI4ja2tMe3cApOw9hLtPbMkSfXNalINMPEwf2+qWpIfBJaMQIc8wt9qhcKiwngIsFBwhcCjVJWBqiNnY3greRFMRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720814207; c=relaxed/simple;
	bh=IBARnuxiOw1Ai3aHVjD4uAdk0HfX+7XQL4h4zn8nBTM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=PlB+piVJDsaeWTCB65MMxEDBPFTDnkiPFwDAOxlaVjYzX8FgD1BXUf2Am5FypA2LTby2QGb8PojiaNHxw7eOeRZmghdgq33csrlGzZXs8s0z8rBJDs4URkr8KkuNnCQdyGzTLHkiX8jU65UO6wUhnUL6ymWEEzqxfCS5waZrKwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqoWhLAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8180BC32782;
	Fri, 12 Jul 2024 19:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720814206;
	bh=IBARnuxiOw1Ai3aHVjD4uAdk0HfX+7XQL4h4zn8nBTM=;
	h=Subject:From:Date:To:From;
	b=CqoWhLAu4APTAzFoZxUFvhBI10eZ36/5OmNk/L39g2+wUNGtSZDYTyHfBeXe3a1+a
	 gWMokowipmGmBrMANdXIVjKhzZviRc+TYYj1tlyb0ik52VsSX/CmkakBUmRUd1gb71
	 NvBwsXxIFOBe6WWsZFrXHk+7ZxEsTso96jaa1ju9r5YgMof2ui2pYlY0L/pq+8m2Bd
	 as3fDNq0BFySQhfI3J1f0xmzJwQxVLazGPL6BMLuJnt6ZoJku1pwf1+XPFfFWO+wkN
	 AV9MN0odW65GzzNGdz35FzbgkB83DGcRKM1L0jkuTX8EilxWdBisUWQ9SY3zcy+vW3
	 hGppC087uhnvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A720C43153;
	Fri, 12 Jul 2024 19:56:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <172081420635.11467.11815777698583698303.git-patchwork-housekeeping@kernel.org>
Date: Fri, 12 Jul 2024 19:56:46 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] Add support for AD4000 series of ADCs (2024-07-12T19:20:00)
  Superseding: [v6] Add support for AD4000 series of ADCs (2024-06-29T19:04:00):
    [v6,1/7] spi: Enable controllers to extend the SPI protocol with MOSI idle configuration
    [v6,2/7] spi: bitbang: Implement support for MOSI idle state configuration
    [v6,3/7] spi: spi-gpio: Add support for MOSI idle state configuration
    [v6,4/7] spi: spi-axi-spi-engine: Add support for MOSI idle configuration
    [v6,5/7] dt-bindings: iio: adc: Add AD4000
    [v6,6/7] iio: adc: Add support for AD4000
    [v6,7/7] docs: iio: Add documentation for AD4000


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


