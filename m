Return-Path: <linux-spi+bounces-5287-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A779A72C5
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 21:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23BB1F23C84
	for <lists+linux-spi@lfdr.de>; Mon, 21 Oct 2024 19:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF24433AD;
	Mon, 21 Oct 2024 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UWF8u2Q8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B1F2209B
	for <linux-spi@vger.kernel.org>; Mon, 21 Oct 2024 19:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729537224; cv=none; b=TWNBOVStuErqyOTzfCdBmlXJY+rJrr5OaYV9dTNHg8WBo3j97jxv3+szldgFOrnZEbfTpD43Gdik8ME+z0VyaiMkDHsT82G0ZZyMoYYExlv0OmAfM+sdl4khWw6iEhQBPvf7zn4puZcg6oRiTMMBeqh/2idRSMeI3g390gD9TOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729537224; c=relaxed/simple;
	bh=U58X/g1elMdt0x0xdmW0FaUwhHgHCla+CZEaey3Iw2s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=e5YSJs0sv3MM4gvxkB4gxWgqaxRuc2K1peiv1YwAaOGyrIBSvDCbG03k4rhKphowJmxhZ0Ztl+RaF6IdP9VpNcAbOnRlfv55WtbhMd12q4DMfb73YP+Swk/rV9HV8TQWpOS+9qzFkMF6YFhPi3hqMjgRo1EfBOnko+wokWc0WFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UWF8u2Q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5E1C4CEC7;
	Mon, 21 Oct 2024 19:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729537224;
	bh=U58X/g1elMdt0x0xdmW0FaUwhHgHCla+CZEaey3Iw2s=;
	h=Subject:From:Date:To:From;
	b=UWF8u2Q8UCEiFqalBXhT/PULMS0rdDal67vERelsmE7XtVnkVXupJRW7japzQdyfI
	 0PfZseDZG7ssUUgGZIa/nm+E6XOx5FT50v2vU9wfA3fm7tySmEYct8dqdwgomQHfDP
	 tZNwl2GIH3uQDQ79AkthShfHt8MTY11y+ZXQwXWlPI3E0+0kuhNM54kE11mlq7cBi2
	 iSyR5RYdieiyJi4T/zAozSDTC0ALoQWXXjAD242SnhMnL4F5gXLU1q42AurI1ZVdl4
	 CV/3Z7C4GbQ+ujJduR2lSOdXBVwdgtJLnurOb5Ywl7nv9QKF9BohkINBVoleFAw4pR
	 F0fjoFvlBptrQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F41193809A8A;
	Mon, 21 Oct 2024 19:00:30 +0000 (UTC)
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
 <172953722958.410617.163812889430455426.git-patchwork-summary@kernel.org>
Date: Mon, 21 Oct 2024 19:00:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: mtk-snfi: fix kerneldoc for mtk_snand_is_page_ops()
  Submitter: Bartosz Golaszewski <brgl@bgdev.pl>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=901427
  Lore link: https://lore.kernel.org/r/20241021142113.71081-1-brgl@bgdev.pl


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



