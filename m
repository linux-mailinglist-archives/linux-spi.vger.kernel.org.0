Return-Path: <linux-spi+bounces-10351-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 543F5BA8CCF
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 11:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D577B7B7A13
	for <lists+linux-spi@lfdr.de>; Mon, 29 Sep 2025 09:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5439A2EDD76;
	Mon, 29 Sep 2025 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1yuqYjK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3054D26E16A
	for <linux-spi@vger.kernel.org>; Mon, 29 Sep 2025 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759139810; cv=none; b=BPC/PPxlFnDnmKXCkU1NnZLcDAfLPeCbWzUDqa1Ta/UE25aKWoH19CmYxV/DjXHujCUj5rH7RqIgbrnTW2LOr+wEF2EHU9S1HXq/H0iIKNE1adEyfnYPmVPhOi14LN3aUrkyLcHAm/CQhs1PhmrHUBfLXIPMypcsnnNdoWzJ56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759139810; c=relaxed/simple;
	bh=cIxTTTTF+XKLsOf4laGM545D6Q3ndRtrBvoUXewPaT4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=REBs4pDEj7zrd2LZg+iNZXRQmGSMq5G6YWAks+4z/PoU3ybLoz5vQ8NE/aPWGSv6zjW93QcifVxgxs91RT1VUy8rmtbbY6JKDXBdP25VZQO+i9wNIvUFknajpR9wGfOeghZRpbWs1VTLx50tNspEgPwcavJcQAYMh06Mh9vjN+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1yuqYjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24C5C4CEF4;
	Mon, 29 Sep 2025 09:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759139809;
	bh=cIxTTTTF+XKLsOf4laGM545D6Q3ndRtrBvoUXewPaT4=;
	h=Subject:From:Date:To:From;
	b=X1yuqYjKkVlzbTIXWB4/sAVPSgwp7s8IaJhtZpkx8qOjq8ZM2uycOBdGz5NqLrL8o
	 I4Ks/A5pni1PPv8Y+ujKVYGakT/xKgvxLDj39I2nqroP//6te0nFrXY9TJprdDWlcB
	 S1YAOKLXd6y9oToV09eo+1Uri5pZWGd6KAr7iS+Ta2w1uIPTheGwbVYFG55qQM+XUI
	 +n1o3mcoA3q7UPn4N1ARl5b632n+3Z7OM9wrg2K0zdJpYpL/VcA1iXTGiJP3sBhK+v
	 sSGLN5Uu0pQqxie+Yg2klBC/qLGWxtVIvEVFkN4O86GKXvrYHGTQz5nUljaqGjzd4u
	 IrbH/EjNXbfJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AECDA39D0C1A;
	Mon, 29 Sep 2025 09:56:44 +0000 (UTC)
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
 <175913980336.1156984.2739629817033515554.git-patchwork-housekeeping@kernel.org>
Date: Mon, 29 Sep 2025 09:56:43 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Axiado AX3000 SoC SPI DB controller driver (2025-09-29T08:58:03)
  Superseding: [v1] Axiado AX3000 SoC SPI DB controller driver (2025-09-15T13:11:54):
    [1/3] dt-bindings: spi: axiado,ax3000-spi: Add binding for Axiado SPI DB controller
    [2/3] spi: axiado: Add driver for Axiado SPI DB controller
    [3/3] MAINTAINERS: Add entries for the Axiado SPI DB controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


