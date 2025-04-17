Return-Path: <linux-spi+bounces-7665-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A99CA92E77
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 01:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75B587B2951
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 23:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5192222C9;
	Thu, 17 Apr 2025 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkV1z/YF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4582E21506E
	for <linux-spi@vger.kernel.org>; Thu, 17 Apr 2025 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744934164; cv=none; b=juGz0wdYF/enPfl0ACQOiSjj/yaRtYO/eJrMMDrmSpO+9lUAf07tOEREqPxfA5r1zX7Nfq+H7k32bkhZn9ckhv+HCt7SwTt08ve2Kd1RXhiIYo/9fdK4Sh9swY6gGo7cmB9gcxtr+U9dXOiFsTVQVwyKYPv154Op0t+K5t1/t+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744934164; c=relaxed/simple;
	bh=b8aIaUzZIzVwCck1dne/EMNEfPxH358GgY2wrPOcvao=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=TyO1/9S5fVG6kpmTdORq2lFDR3H6+JVxbTjfa5RYjyv3fXJ1saoEiV1IkClNDcA37S/KSFHWN0CABfEytmsNzLXHvt3bQLvxYzlI/0vPpG/wgQrzS85f528Juq+aXtApNlEC3uCfTl0krkPhFYyxBZmmEY7Mb0iA+QF2ARfOfj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkV1z/YF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A00C4CEE4;
	Thu, 17 Apr 2025 23:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744934163;
	bh=b8aIaUzZIzVwCck1dne/EMNEfPxH358GgY2wrPOcvao=;
	h=Subject:From:Date:To:From;
	b=SkV1z/YFuGaQ15/v9Qk+5RTIMrn7iny3Z23skIXEtg9Rq6JpbOYocD1k9H+f4QD3y
	 Ge8h6yQvbCEI3xkrFIGbBsAeGByvwyjpTvM5tI1uspkMM7sMCePrwA/V+6EwZpKCXS
	 t+msZ3354zMom1UVm0iFxWADtrJmG39GSWx6R3EFubOGO8qycRJgkheUG2fHcs64cH
	 pbpGHyOCbuQIhrhqylTGXQQDhSqbL6s6p36Yn00fn34sbIQgHzwh8C0l5H49kb8AFX
	 kLjeoJMvfhyXQR2EyaNcd7rTdCeIGLc7WXZmy3qNTiRBKJxnpyzQ+VCWeiPhNxgeLt
	 wYNRS2z2lfE3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE9E380AAEB;
	Thu, 17 Apr 2025 23:56:42 +0000 (UTC)
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
 <174493420145.55106.14062266415870897368.git-patchwork-housekeeping@kernel.org>
Date: Thu, 17 Apr 2025 23:56:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] ASoC: add Renesas MSIOF sound driver (2025-04-17T23:22:40)
  Superseding: [v3] ASoC: add Renesas MSIOF sound driver (2025-04-15T01:33:21):
    [v3,01/10] dt-bindings: renesas,sh-msiof: Add MSIOF I2S Sound support
    [v3,02/10] spi: sh-msiof: use dev in sh_msiof_spi_probe()
    [v3,03/10] spi: sh-msiof: ignore driver probing if it was MSIOF Sound
    [v3,04/10] ASoC: renesas: rsnd: allow to use ADG as standalone
    [v3,05/10] ASoC: renesas: rsnd: care BRGA/BRGB select in rsnd_adg_clk_enable()
    [v3,06/10] ASoC: renesas: rsnd: enable to use "adg" clock
    [v3,07/10] ASoC: renesas: add MSIOF sound support
    [v3,08/10] arm64: dts: renesas: r8a779g0: tidyup MSIOF node name
    [v3,09/10] arm64: dts: renesas: sparrow hawk: Add MSIOF Sound support
    [v3,10/10] arm64: defconfig: add Renesas MSIOF sound support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


