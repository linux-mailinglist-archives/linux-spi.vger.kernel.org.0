Return-Path: <linux-spi+bounces-9764-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D5CB3B2C3
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 07:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3DA581FA3
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 05:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44D51F4634;
	Fri, 29 Aug 2025 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ln/IhDD+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE328BEC
	for <linux-spi@vger.kernel.org>; Fri, 29 Aug 2025 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447010; cv=none; b=NiqY6mAeqfCPplTBiOvwkZ2wGCfqJAb7EXbVp423CwdzXqpkXLaA9IjNb0Brgn3JNsbgxy5mXUDDmoJUf0mEOencmA+jlrLUHiEAdI13oioPXkn6qa75ehF2xCneRIajBSpfud0lJZp5HgkEUaGfoOrIhXJKzXJ5nlUsTlJttNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447010; c=relaxed/simple;
	bh=ylTTkBtIV1QLZdAjjz9PNJY6XmpPThSnM2Ir8jhtjns=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Fk6J5bNoPhggn9huvHoAbIZpeKdMNGFJKAes6/jHhaNFBEBcBQanauWcQ1RpOv3s1AjWbc0mDWoLpcQQijbIDKP2Tq3+A7ELCQ6kh+KLEJLyuN2z9N+sVEnjIAsJGooPapOZuOcEltbYPS/kWw4Tc6LGg+b75mT4aIYOShgAAzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ln/IhDD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2137BC4CEF0;
	Fri, 29 Aug 2025 05:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756447010;
	bh=ylTTkBtIV1QLZdAjjz9PNJY6XmpPThSnM2Ir8jhtjns=;
	h=Subject:From:Date:To:From;
	b=Ln/IhDD+DoCXnm1jy/LJ+4FBaaFKRaJA3X/UPQ9N29RsPdXBYYYMUqNS5Kqe7efIK
	 4j6JiBZbzsU8ix9ipfLZCd83a0gEbDmuhT/T0LRnMu9BOGVKr7UYDIRVTTDqqkyWgk
	 xXNcmXT4gg5hw3V9DkVDetLur46wXhMnm+bjy9xQBMcODTrFB5oLEYrZswj+qYmMoZ
	 bb/PKd2qabyQfEL+xIlhWPL9ja5KHuGefuv1NKcPIwIcg9RD7sQuAgGH2GbKI3c/+i
	 f+emDVk5sqpBlV8d9kHsU4p6Y2xWewecZEwI0PqP5zv2ubXJBjsA3D3GIRzqynn7Vf
	 shjQ90Oh+vQYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BC6383BF75;
	Fri, 29 Aug 2025 05:56:58 +0000 (UTC)
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
 <175644701691.2090095.12269058790952846023.git-patchwork-housekeeping@kernel.org>
Date: Fri, 29 Aug 2025 05:56:56 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] support for Amlogic SPI Flash Controller IP (2025-08-29T05:16:13)
  Superseding: [v3] support for Amlogic SPI Flash Controller IP (2025-08-26T02:10:11):
    [v3,1/3] spi: dt-bindings: add Amlogic A113L2 SFC
    [v3,2/3] spi: amlogic: add driver for Amlogic SPI Flash Controller
    [v3,3/3] MAINTAINERS: Add an entry for Amlogic spifc driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


