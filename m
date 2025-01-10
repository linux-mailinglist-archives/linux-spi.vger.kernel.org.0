Return-Path: <linux-spi+bounces-6319-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD2EA09684
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 16:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71A553AA312
	for <lists+linux-spi@lfdr.de>; Fri, 10 Jan 2025 15:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D143E211700;
	Fri, 10 Jan 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1MVlvie"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD113211A0E
	for <linux-spi@vger.kernel.org>; Fri, 10 Jan 2025 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524583; cv=none; b=Q0OuwbER/n1YNOSg4RF1rkzFdVdC7bz0bHweor7gjp65D7/QwkR0/257MdwLYFAzP91nkHeM2dvdiNqeir0rXH8pqgc3myfHZt99YuWOZCao0xzwyJ8yfSh3lKd4NjfxBGkoVrOb3Q+qoBZN11Uw72fTGMenwwkG6tJgZMjDX1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524583; c=relaxed/simple;
	bh=9i/KcivCSxrNsyr1OuB9yUsIL/OPjEQe/Snkw8OxZUU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=CDs+PpCpWU2cCkiHwUkYKYb+6F1AAdC3OCFqRCId2ZlMlgFaOxySLCrZbZ9jTrcMCzsF4CU10XOYp9Hy8oq0IH7y06NoSf2Nz5EmWGMKTY90zWczZ6Tibrsu6cYRiefSlqME4ca+C57mD74lNGoOmmJkLj88DNl4F1LTU2x6jUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1MVlvie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EBFC4CED6;
	Fri, 10 Jan 2025 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736524583;
	bh=9i/KcivCSxrNsyr1OuB9yUsIL/OPjEQe/Snkw8OxZUU=;
	h=Subject:From:Date:To:From;
	b=T1MVlviergcMbGM+JCFovQVcMCBE65kmNT9RukJaduDN4d1MgyRFJBIb938kH19Wv
	 UJiDxYYakpWF76zys11OZhD46o0a7boC1AX8yRlPk7ikZDZcFxqyQ6Xaxe4/I4NXpV
	 +ummcsiKCLycH3DiqJSj2VHIuwTRRkWQO0nv6TV4u/jRDBqFplN3Y2quqkUgTcDUhA
	 Ckqsa8H2gXro2i6BzHf86Bq6mjSoGhknZ4i6ERAvR3FYkbEuEiHArHbCKlM9/VP5Wf
	 6n1MLMWunjoIk7BdjYXrYUAOZGSVyKysxrQ/3tIZMBtThHG3x3Wa4iJ5m4jOMakiR0
	 7e6vrMI41zcHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A54F380AA53;
	Fri, 10 Jan 2025 15:56:46 +0000 (UTC)
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
 <173652460474.2113608.7845289842928295067.git-patchwork-housekeeping@kernel.org>
Date: Fri, 10 Jan 2025 15:56:44 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] Add support for SAMA7D65 (2025-01-10T15:25:39)
  Superseding: [v5] Add support for SAMA7D65 (2025-01-07T16:07:22):
    [v5,1/5] dt-bindings: ARM: at91: Document Microchip SAMA7D65 Curiosity
    [v5,2/5] dt-bindings: serial: atmel,at91-usart: add microchip,sama7d65-usart
    [v5,3/5] dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
    [v5,4/5] ARM: dts: microchip: add sama7d65 SoC DT
    [v5,5/5] ARM: dts: microchip: add support for sama7d65_curiosity board


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


