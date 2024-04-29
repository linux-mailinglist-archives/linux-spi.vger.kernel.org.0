Return-Path: <linux-spi+bounces-2577-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 032D58B5395
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 10:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D61280F13
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 08:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1318B17BB4;
	Mon, 29 Apr 2024 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkRnkn0+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301B17756
	for <linux-spi@vger.kernel.org>; Mon, 29 Apr 2024 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714381005; cv=none; b=AC3VdS6/U5ijGOoclHLDHBwi/Kk7usS0/fk/YpsbLAnxYxRd2hMElF+PtCtmA0+kXQLYouiYOXeYMQXF9AHSsGIitSO5EDB/SH2fKHmeRjIIrpJyDw++7jWuRDgC5yQ9KQCvOPtRoNqtboXCKMSjHaktzCoXrLlbgqwkr/F4zoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714381005; c=relaxed/simple;
	bh=PmwiCCiEAVEqwZTK3dqfdiggZtQwIMyDFHY9XvBrvbI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=H2bZQnjax8hHRDtJZiQYiipzHSgppBvVDuCOhN+qI/I149b5oMT6zR8/eKU1dTa7tl+qWfgd3riyvbpgnO6qFBy093TaH8+feWyWpz4AOnETPgrAnnt3YyKrOaAFLYknSAr8tC5swZThA3ZzaPLj3s8gmqo5ku/u6nyQJ6Wpdq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkRnkn0+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77D5EC113CD;
	Mon, 29 Apr 2024 08:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714381004;
	bh=PmwiCCiEAVEqwZTK3dqfdiggZtQwIMyDFHY9XvBrvbI=;
	h=Subject:From:Date:To:From;
	b=tkRnkn0+mi5JomqdTsqbLa8zlDi2dY2hR4iw/2MNLgvg+/1s84qarvtUA8IXZQLO8
	 jLmtXOvG7sXBL+iA6n9duDE6y4NYMd3y2xOzDLDLptB3erTU8GFw2NV07DiLo4HHOK
	 aVrlKJyHbt7wvpF+UOA9XL/yQfnO0/XrvWPPK5HykkwRHXneVIWLnYnwGcCBl5vJn0
	 VuAsXv8OoRENQfnS//0dW93vDsllLYp2aFK83b8yoMeB3n5JLdaA9mz11Mi1l9ovd1
	 ZYdi7hxKyp72m1LweFgjGoMvDHz4hRUubHuGCJrau4TgZgwF3XNcxUN6XzM3/Eg4lO
	 juI0y12kiMqnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CDFFC43616;
	Mon, 29 Apr 2024 08:56:44 +0000 (UTC)
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
 <171438100430.3050.16748876593502249611.git-patchwork-housekeeping@kernel.org>
Date: Mon, 29 Apr 2024 08:56:44 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] Add add SPI-NAND Flash controller driver for EN7581 (2024-04-29T08:13:07)
  Superseding: [v4] Add add SPI-NAND Flash controller driver for EN7581 (2024-04-26T08:30:50):
    [v4,1/3] dt-bindings: spi: airoha: Add YAML schema for SNFI controller
    [v4,2/3] arm64: dts: airoha: add EN7581 spi-nand node
    [v4,3/3] spi: airoha: add SPI-NAND Flash controller driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


