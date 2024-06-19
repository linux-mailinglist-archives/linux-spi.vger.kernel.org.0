Return-Path: <linux-spi+bounces-3464-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BF190EB81
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 14:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C061F22839
	for <lists+linux-spi@lfdr.de>; Wed, 19 Jun 2024 12:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2A014387E;
	Wed, 19 Jun 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDRv4NOw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7452143873
	for <linux-spi@vger.kernel.org>; Wed, 19 Jun 2024 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801813; cv=none; b=TeaVbu+yEg8aST+XcpEHeVM++QbIf2DJmESklve8VRPyc1AyLOwAwI08YILqBxOirSjAIn5Z/EZQui4IqJnqDKQ0mxOs3E6ZpIaLpDWvRq9tg9Lhl+gAjdUZEYMNNgDK+N5OQzDkEshnk/BcUBLc74wFvu/K0IM3YvAhUfMP/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801813; c=relaxed/simple;
	bh=beZGOpkf0L6fn6XZKMxKDLjyedBNnvus2o1VirJTaN8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FBSGliRDAUsHPH4B5CKx+rjYGzZz5CvZATIyAvcqfhv0cnvy+d2k+dA+rU4uVd+JgyMbileF7p0YpQwI84cwIlsfkG3AonUr7MwEXtiMLL0EAKHsw4OcI42wuC5AWQGTUrNKOmELMsyu8AyYlQgY45DGiLeqpwI+EoteCwEYDUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDRv4NOw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2895EC4AF1A;
	Wed, 19 Jun 2024 12:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718801813;
	bh=beZGOpkf0L6fn6XZKMxKDLjyedBNnvus2o1VirJTaN8=;
	h=Subject:From:Date:To:From;
	b=lDRv4NOwuNLH5nKggx+xvTAkox7ZgaJH08daQNeOPQEH2XSKvHupuFcESC/gQuIeB
	 Hequ/6VLUjj4BLL92i64pxhwgsVEhXneOusS6hc1rXE2n2lEJqKNQaG3nIMeChiGWK
	 qdrUpKCNwBc9LxjQUKmFs5a27l9IhbJqKO4MF5yAhIlswgDLSbY9P0sUJptuCN0RX4
	 zwatbg20pgmCU9LxnuZuvmzHNAIm2DfVIgj/3mQz/oYyz/wDZgZskilDpdxykJObJj
	 oMcoXpoSmKwceQpsQX/6ec/EneqFd3zNuGNPrm/+mhIIxIKhtDoHPbkZJSGEcWfqPX
	 TsekT/rsSMlbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16C96C4361B;
	Wed, 19 Jun 2024 12:56:53 +0000 (UTC)
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
 <171880181308.9323.13149625210554664019.git-patchwork-housekeeping@kernel.org>
Date: Wed, 19 Jun 2024 12:56:53 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: cs42l43: Refactor accessing the SDCA extension properties (2024-06-19T12:17:03)
  Superseding: [v1] spi: cs42l43: Refactor accessing the SDCA extension properties (2024-06-11T13:25:56):
    [1/3] spi: cs42l43: Refactor accessing the SDCA extension properties
    [2/3] spi: cs42l43: Add speaker id support to the bridge configuration
    [3/3] ASoC: cs35l56: Attempt to read from cirrus,speaker-id device property first


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


