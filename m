Return-Path: <linux-spi+bounces-11140-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00668C45462
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 08:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F42188EEAE
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 07:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6815E1FF1C4;
	Mon, 10 Nov 2025 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2Dpt7wd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4421142AA9
	for <linux-spi@vger.kernel.org>; Mon, 10 Nov 2025 07:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762761443; cv=none; b=SHlSadVWE4+pQIRmuAs7aX9V2h67cUodMwytQzC3KT07frL8u73w4L0engJBsywMZbwBxuCCBvWVas9m2wTI1wqRc9w2V91Hp4fOouB94I6iXlFvlGKi9NTEwn1XboTTbHkGKe7bZX66obqUKC1eydNlDEWOyphhKVNhcdPQJ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762761443; c=relaxed/simple;
	bh=z8v2/Bo6OQ2C5UHOk34+dy3A1oeaMeTGeYDK4MlC7+0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=M5SMq6CqEYmCzXOySckmn4WrIodFydPuDeuMYoMpChVRTJvC1FyrZn+PDv7woUW7Stv16iZE8a04EA77a28ExKUqy8uREqltbmwIn4Jn4VK4d0WPDBk1vgJMhdAQP/Ib4hvHYBg/S5+v8V2JogGgHdyao3wc+d9z4ZR63zqfYKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2Dpt7wd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9223C4CEF5;
	Mon, 10 Nov 2025 07:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762761442;
	bh=z8v2/Bo6OQ2C5UHOk34+dy3A1oeaMeTGeYDK4MlC7+0=;
	h=Subject:From:Date:To:From;
	b=R2Dpt7wdFp1XFbHrqRG3CIsx9PD+Crd/CvatyxdsUpAkgUMDi1fdp2f2/LhYfdM/U
	 MD6SwyOXQWJVq2F5I6wR4W8ATB/lSrHf/HLKpo/lS5AvJtVRisgMiJuKQ0cyqENTgd
	 0VCYeksPzwNSwjig/8MWVkpvB2WMrHkx1Dii0pDZPyCx+I4lbk1I0VKZWvO+FvOiYA
	 RRTB92Z/NR+kOjNdhuBfQ5ifrym2D9pf1E4BNbMtHiPpvfX2JWNKDON2eoNSuEOHey
	 gqfFOjRX3h8mBuMEsy589y0ipzpW7gjyrFP12antstHpbM2bdZHyDse7+usOoUZbuM
	 qU/OCRVZmN0EQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0343A40FF6;
	Mon, 10 Nov 2025 07:56:54 +0000 (UTC)
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
 <176276141343.2505120.9289055042054496995.git-patchwork-housekeeping@kernel.org>
Date: Mon, 10 Nov 2025 07:56:53 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] LED: Add basic LP5860 LED matrix driver (2025-11-10T06:35:32)
  Superseding: [v4] LED: Add basic LP5860 LED matrix driver (2025-10-07T08:58:01):
    [v4,1/3] dt-bindings: leds: add lp5860 LED controller
    [v4,2/3] leds: add support for TI LP5860 LED driver chip
    [v4,3/3] Documentation: ABI: add lp5860 led matrix controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


