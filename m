Return-Path: <linux-spi+bounces-5949-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5000E9E7DDC
	for <lists+linux-spi@lfdr.de>; Sat,  7 Dec 2024 02:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0D4D285051
	for <lists+linux-spi@lfdr.de>; Sat,  7 Dec 2024 01:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672AE3FF1;
	Sat,  7 Dec 2024 01:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQcmtJpH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408EB17597
	for <linux-spi@vger.kernel.org>; Sat,  7 Dec 2024 01:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536578; cv=none; b=R3HLa3wH0clN4yom/HS5eGI2esXUgrRLfM+okL31fjhBdsyuwjR7UsmBiSlEY/9r76kCh+AXuuHmmp8cj+BZBLholup4tjWaoINci0H4fplAguYrFAcPQwlLeE8eQTdqWZk3Uiuc/ppgMxUiWkugQrLOH7y70rQTLk6RWXgh39c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536578; c=relaxed/simple;
	bh=buRkNfstOWoNwn7uj9hwfwBpTdTv9KgKlMD1EXFkFUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VTJfH+25/24Jxh0Bjxha0EhcAO3A04LDG2hiWA1khqGIK3L6gwPFBR7HS7JTS7j4gk3fkpiCyG23yRi3egpLA7AF1J1BYWV2XLY+Qo4phuj/O/6LvY54rpMXxB+kh8s01/ZyhTkWURqJnAbHDfBVVh9/vL6HcFa9JegLyVso0Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQcmtJpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAF2C4CED1;
	Sat,  7 Dec 2024 01:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733536576;
	bh=buRkNfstOWoNwn7uj9hwfwBpTdTv9KgKlMD1EXFkFUM=;
	h=Subject:From:Date:To:From;
	b=TQcmtJpHmmFNkfUJUOdiyuNzHRwvr74vAykaLkO1Sf/4PBASsWTyh1q446eEuCh3i
	 nI5eVNhTJyUDeUh88wvpFZPSHRMddIXpQxk/hLNDSCp8VYFjOVqjthMEmWwzJX5WKH
	 VZHOHhHq+a4TjdMulHtUxaN0Qq8/7IcU40/z9Lf8h+jG/U0XQDeu6SpiQUkIzoKJau
	 q/rnMyPtFoB7+/jEYaRBmRTDndIR+IK9PrzUpyIcAPitWtzc49AVvA00evRyLXYiON
	 0r4EQAV0gt5mV7T4Ap5qww4V2FWM89ENrD85XQVC+ImPXDFfsEyOuOjHkOhKAhoL5Z
	 E79iC3IbQdHzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F02CA380A95C;
	Sat,  7 Dec 2024 01:56:32 +0000 (UTC)
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
 <173353659142.2871552.13086141745678048926.git-patchwork-housekeeping@kernel.org>
Date: Sat, 07 Dec 2024 01:56:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: zynq-qspi: Add check for clk_enable() (2024-12-07T01:52:06)
  Superseding: [v1] spi: zynq-qspi: Add check for clk_enable() (2024-12-07T01:32:58):
    spi: zynq-qspi: Add check for clk_enable()
  Superseding: [v1] spi: zynq-qspi: Add check for clk_enable() (2024-12-07T01:47:27):
    spi: zynq-qspi: Add check for clk_enable()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


