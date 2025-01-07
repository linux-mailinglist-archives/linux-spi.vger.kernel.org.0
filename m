Return-Path: <linux-spi+bounces-6250-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E563CA04754
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 17:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52C123A5DC4
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 16:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CF81F3D20;
	Tue,  7 Jan 2025 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjIGPAhK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D351F37CF
	for <linux-spi@vger.kernel.org>; Tue,  7 Jan 2025 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736268969; cv=none; b=Wv+FhY1wYNidcl6OOZ+8C7Nf9cdMrNOvGd+O3uii2qVRuZuM72f02vAw0t1ruO8jCzAnTXFOD08d/e85N7YwPCDrM9HgEa2cQnrfnDCdV8bav9QyeqIEcAddO011JfUb2ob41rU/SJJ1mKoO5zl8SZk3H/uUlJ+3mv25P6Lu7AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736268969; c=relaxed/simple;
	bh=q5MENtjm3lXzFSVmbzS6TMvO/YHOKDDIeVNCvZuhJnI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=EYpWA/uk12f6uX/fnSlUVmp1wOxpGizxvCwqaZAaK4lZ3FHa7bjxcNX6NiWUERcVm8aLmIgRYFdX1HhHjLrBR0jPy3Y71wCYkkESlXnqJmV2ED6GIr5H9yqnf0IWKlTuEtifavM3PGoYP86Ne8XxAw8vZ6L0bdmv84HTh03BJnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjIGPAhK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCF8C4CEE0;
	Tue,  7 Jan 2025 16:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736268969;
	bh=q5MENtjm3lXzFSVmbzS6TMvO/YHOKDDIeVNCvZuhJnI=;
	h=Subject:From:Date:To:From;
	b=CjIGPAhKmQ5yXeDp+5o5pu/E05g/7ZUhwCZ9mqZpjuENf0lYpmUL0jwO5Lb01PJ7W
	 U/YvOYSIpSImcx0U7Ar+6Y4emin3xeFmBEQ4CU9qf31MEnQDUHn88ky/LyIaJQaHg1
	 ILpppQlTEeoQDTwHDa7PDlNdikaxNwWlYd5U5PtJ3P3iKiPVofBRGNufz2XQps3xWf
	 HxLJ0WrBiEvnbFc2ml8ZOsVSKTIl9S9uggUUFhjy2FwQBBqbFCu/Z69OrDYBxkKX7H
	 VKSlezY0j6qN2gEPRmzv0ogFs6qqs/Er/qmA02IZzg/55+Aid5AHjc3a8809D5FNcY
	 0f2jWPGfDq9aQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF5F380A97E;
	Tue,  7 Jan 2025 16:56:31 +0000 (UTC)
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
 <173626899017.32785.9397495405747911178.git-patchwork-housekeeping@kernel.org>
Date: Tue, 07 Jan 2025 16:56:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] Add support for SAMA7D65 (2025-01-07T16:07:22)
  Superseding: [v4] Add support for SAMA7D65 (2024-12-20T21:07:01):
    [v4,01/13] dt-bindings: ARM: at91: Document Microchip SAMA7D65 Curiosity
    [v4,02/13] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,sama7d65-flexcom
    [v4,03/13] dt-bindings: atmel-sysreg: add sama7d65 RAM and PIT
    [v4,04/13] dt-bindings: serial: atmel,at91-usart: add microchip,sama7d65-usart
    [v4,05/13] dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
    [v4,06/13] dt-bindings: clocks: atmel,at91sam9x5-sckc: add sama7d65
    [v4,07/13] dt-bindings: clock: Add SAMA7D65 PMC compatible string
    [v4,08/13] clk: at91: sama7d65: add sama7d65 pmc driver
    [v4,09/13] ARM: dts: microchip: add sama7d65 SoC DT
    [v4,10/13] ARM: dts: at91: Add sama7d65 pinmux
    [v4,11/13] ARM: dts: microchip: add support for sama7d65_curiosity board
    [v4,12/13] ARM: configs: at91: sama7: add new SoC config
    [v4,13/13] ARM: at91: add new SoC sama7d65


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


