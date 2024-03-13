Return-Path: <linux-spi+bounces-1801-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBEF87B3FA
	for <lists+linux-spi@lfdr.de>; Wed, 13 Mar 2024 22:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15CC1F22A4E
	for <lists+linux-spi@lfdr.de>; Wed, 13 Mar 2024 21:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10DC5336D;
	Wed, 13 Mar 2024 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8Lzv9XV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFCD5677A
	for <linux-spi@vger.kernel.org>; Wed, 13 Mar 2024 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366986; cv=none; b=r7c3n+vqvPBb5/JlMmGVdB4X/ykO0IhRcH9rYGn6aJYN4ZXjipX0FZee9oOL0r3om06ZXUcAt5CBm6KteJkA6gAjNPFZzz2MIdsxi4BsM1EFqdKtcQ37rgAx9dcyRDQPFGKmRJ0RjP9smOpRg/wvuv7HP4aYyyswD3gsC61WGw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366986; c=relaxed/simple;
	bh=hXo3n3F+dyBfR+WIscchv3i6R/F9f541/xyKANybrgI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=qr/8S9RoIyFWI6YOtCvn1d8iZWz0Pbvt2LHvrBb9Oygt5aVKK57Jr3D1lRLv/2VHI8PMTDDKblFB38LrKtrsHI42/W26DIhyqq26Kvfu7C8i/LgiJSEo6Gt166HrETb4QJzkVEgTJKSYAxsnsQ3uL4wbn0eCscdbAfCVjcx4+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8Lzv9XV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 589F5C433C7;
	Wed, 13 Mar 2024 21:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710366986;
	bh=hXo3n3F+dyBfR+WIscchv3i6R/F9f541/xyKANybrgI=;
	h=Subject:From:Date:To:From;
	b=g8Lzv9XVgA6cn/KDBLR6vfkPdWPcLSv5ONCl96/VerXDmbdUjOsZEHYZ6T0bWg9D/
	 EAaGYHaIu8rkKCqgcMuE1CEBsN/8G1EsOTj1je9dPVUZUsh9L4+9a1/hqBNLNewypm
	 FzV2gBcVqJ38IZbT7yeWNYFE53A2G8QBvj8fRdB/HoBeUn2DzW6JqP9lYe2COetMd0
	 53HBzFxC6kA5DhGFazwSxC2Vzbzq0GE8VEPnsMHl2P74yOgEK9FTaMPAcp5J5fB6Px
	 OGn5EW7xSMndJt4+mOXyViIzNnqkQiwD3KuoLEHcZNqaq+IFpclQso8P5P0GIOjZXZ
	 HUPchbF/e779w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D8AFD95054;
	Wed, 13 Mar 2024 21:56:26 +0000 (UTC)
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
 <171036698624.5872.14680578263280574447.git-patchwork-housekeeping@kernel.org>
Date: Wed, 13 Mar 2024 21:56:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-imx: fix off-by-one in mx51 CPU mode burst length (2024-03-13T20:58:19)
  Superseding: [v1] spi: spi-imx: fix off-by-one in mx51 CPU mode burst length (2024-03-13T18:00:03):
    spi: spi-imx: fix off-by-one in mx51 CPU mode burst length


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


