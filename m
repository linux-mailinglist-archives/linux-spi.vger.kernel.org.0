Return-Path: <linux-spi+bounces-8864-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFB6AECBD7
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 10:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 646883B1F06
	for <lists+linux-spi@lfdr.de>; Sun, 29 Jun 2025 08:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293F81DA10B;
	Sun, 29 Jun 2025 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ux/MSkUa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BF4EEC3
	for <linux-spi@vger.kernel.org>; Sun, 29 Jun 2025 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751187493; cv=none; b=O/p0mj1yb7awMuqKF0dvC7KsSfpKA7+HtX/FuqB9pbIj9EDGYxhmjlxO/lZbGwDA/Ko6jqDMWYnuG+YXm7JaKG3C4fJlC+7/sSI176OZj/tE7TitOJKTjnGHSDhXXM/ySA/jkEwOfsL3icwdnYKbI40qStxN0vACCNMzMWxsHgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751187493; c=relaxed/simple;
	bh=iC6igCEYbBbfuYAJezx+Xg0HMbLXxaXg2odO8y7TNl4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=d4nXMFt46S0vIg0ZVGgO3pstIqhWSVw0sMhV4PFRIBiSlDBRLFXUPZu3R5EKErBiXqPFJj6sHGJa71kbXtPMch14Qhh49leszTmmZGY6C+BLR9TwlenB7ki0p3ZwPxFU+FPSSr1ldUsNMYbtRy0UNHpreERu23nLE/8cgJO5gmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ux/MSkUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C1DC4CEEB;
	Sun, 29 Jun 2025 08:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751187490;
	bh=iC6igCEYbBbfuYAJezx+Xg0HMbLXxaXg2odO8y7TNl4=;
	h=Subject:From:Date:To:From;
	b=Ux/MSkUasyCuao+oPHNsSTCznQVRO7tY8jjw04YXuY+r7jpVpe9SsRCY0pQNpdZYo
	 lVAD9AuiYzd1ml5QzkI8UanRtYKfXGdDYwOI5lOs+O9zG1Nm/ua3fFd79+4zJWc5FO
	 sG/3rDcD8OI6bEHUTgYhbxcxIYnKdrargbjf8XBSqC63NjXh+bqsb8OCf6tDGwC77f
	 9/uwTKVfqBj3Lg3pVU9ZX9QM6rqYo/d6PiRaM+F76c7RzF2NK2F0cIkiCJiq75xeG+
	 WbqiWoo/JvRct1YrzAdwIEHzfLJrViDNo8IuD/Mud7uPzsWvR9/9F0hNFc3bHIk/D1
	 xmjk7CjWa7P/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D4038111CE;
	Sun, 29 Jun 2025 08:58:37 +0000 (UTC)
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
 <175118751570.2367870.15689261403019002524.git-patchwork-housekeeping@kernel.org>
Date: Sun, 29 Jun 2025 08:58:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: sophgo: Add SPI NOR controller for SG2042 (2025-06-29T08:23:09)
  Superseding: [v2] spi: sophgo: Add SPI NOR controller for SG2042 (2025-05-25T14:58:40):
    [v2,1/3] spi: dt-bindings: spi-sg2044-nor: Add SOPHGO SG2042
    [v2,2/3] mtd: spi-nor: Add GD25LB512ME GigaDevice flash_info
    [v2,3/3] riscv: dts: sophgo: Add SPI NOR node for SG2042


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


