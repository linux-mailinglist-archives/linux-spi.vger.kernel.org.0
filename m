Return-Path: <linux-spi+bounces-1545-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B500586B3F0
	for <lists+linux-spi@lfdr.de>; Wed, 28 Feb 2024 17:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CD4FB212A3
	for <lists+linux-spi@lfdr.de>; Wed, 28 Feb 2024 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA9C15CD64;
	Wed, 28 Feb 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvsOCYw0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4CC1487DC
	for <linux-spi@vger.kernel.org>; Wed, 28 Feb 2024 16:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136036; cv=none; b=glKnZAkVmFDvBWNT+4CuwGApk+/QehodptHNRJpvT4VjtfaJw3m3HmMJFuLgFaMHGLUrt5XGqx31DiK92HncACaqVE1g5LEehMre8Zvv0uu733S4iI9z9cRMYV/+vX+hLZQJPqiQoAnqG3vrcoxVoOVuOmxDV7KWAmkTi/+6qOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136036; c=relaxed/simple;
	bh=iQZbkH2tPbPOoHPB93twfPGOPtT+kpLmz+l34KwPdA4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=BjURWjHmS5GZ7vUPwyud1qQXBOo/+lZ9L7SsPVjmTpsZ5l9dvPqZhUo3XYbsB3WH8wm9dSjGEFEV1zwOfBO3sAgDiWlYs4r8Vc2RuK83x6J7eQ0kWl8Sn7mkYcmfG3PWu4V3sk9VlsIpRul5KqaK+dzi0Q9Mj+7VHFYPXQN1rK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvsOCYw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D71BC433F1;
	Wed, 28 Feb 2024 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709136036;
	bh=iQZbkH2tPbPOoHPB93twfPGOPtT+kpLmz+l34KwPdA4=;
	h=Subject:From:Date:To:From;
	b=FvsOCYw0ZxFIIb+C1oa3LY2hYlT0HY5f7lE4cQR5mEQvv30pZb/9FY3302QxzrrhJ
	 6y3Oj3xbtohmnm/Mo4cKTU8r7VW9cjWVFm9CfOJ5CqW2X9a0kwYHAAg/ear6AiZGDC
	 fRwoq3zcdNAhju2OgYy3sZqGXy1Z4i3Q/wEhuvjPWOT9SnDqWOzbBnWLlAb2obf4gf
	 nrjfcdu3bbaGBtCRICrapkR31ySeh/jn1uLPKNNQgmchsdqDswMe/1qNU374jZU4aR
	 aD6fG/X/uqEXxsPX+E3cHbQkacgdrEZUkDU/ZSZu2B37ygoOlne0pziuvtvVYceher
	 WhDLcFfDu9hFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA19CD88FAF;
	Wed, 28 Feb 2024 16:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <170913603586.13355.6817912472400188358.git-patchwork-summary@kernel.org>
Date: Wed, 28 Feb 2024 16:00:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add support for sam9x7 SoC family
  Submitter: Varshini Rajendran <varshini.rajendran@microchip.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=829209
  Lore link: https://lore.kernel.org/r/20240223171342.669133-1-varshini.rajendran@microchip.com
    Patches: [v4,12/39] dt-bindings: serial: atmel,at91-usart: add compatible for sam9x7.
             [v4,16/39] spi: dt-bindings: atmel,at91rm9200-spi: remove 9x60 compatible from list


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



