Return-Path: <linux-spi+bounces-12271-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C6AD0BC60
	for <lists+linux-spi@lfdr.de>; Fri, 09 Jan 2026 19:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7A763008EBD
	for <lists+linux-spi@lfdr.de>; Fri,  9 Jan 2026 17:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578EB31D75E;
	Fri,  9 Jan 2026 17:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="crvf7gXD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357162857C7
	for <linux-spi@vger.kernel.org>; Fri,  9 Jan 2026 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767981598; cv=none; b=jFFdzGp1qpI9YI5i1mWhK6TD5FDkta8pYnYjLIw3kZXRWOgftDuEAVwpPCwTbsDsDbu8xInFETR49UKJeC+4SYEE6WXKWctWj6aQ0Lmn2U8wPR7hNj2jlQZeQzIACQGqDz5MdyFIjsRWqa+FtB3SKVVt+n3eJMfnAMsG/7OUWLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767981598; c=relaxed/simple;
	bh=X9DvYEAtBRWJ8n1rISmbSN5n4ZkR4mdOfia7KnWFPiQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=FaPRj0MCUd5+887H2Um2yZzrr2RjVS6gaaFM6sseO60sSmNwW6MPs1k0jZsKoK21xoDe1XiFDAEAoVVmPU7GmcKc+Wy9XJT44gPDaAwHo27LAksRr8uyvs2acEy7I3FA++IwqosoTPw8bvm6X1k4+qXaZ1luzEJgIEi7RkYf9hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=crvf7gXD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF54DC4CEF1;
	Fri,  9 Jan 2026 17:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767981597;
	bh=X9DvYEAtBRWJ8n1rISmbSN5n4ZkR4mdOfia7KnWFPiQ=;
	h=Subject:From:Date:To:From;
	b=crvf7gXD9YrbYUimEJ9WpztuKUsSxybCnDyTNtlRhtPs8lGXd6b0rYu9Vh7I3YW1m
	 XHoeyGFUFex6/WD70+9F9gOors3j2WakJpZWp2n2MQoVFO+WMx/vFu0JhKaKjJ0JT+
	 sY70khyRNcgT1iYeEbn6OHsaqdfc6LcLZLtWMQdAx3WTlSvRwj49gEWoPHpgFL/29Z
	 2qo/DB+H5dycY/tggZrQ6h8usiI07yUwP+TicSHgOy2UmjxNsVJpJ722Lq+CKJruNh
	 JaL5sJC3H4hDUSpMXgHGRSDEs0Kg5DIv12pRdQ7DBvzYNan6hHJSBKeSmOD3Np0GTY
	 UlWPXHfRPF5qQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5BDD3AA9A96;
	Fri,  9 Jan 2026 17:56:34 +0000 (UTC)
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
 <176798139326.349936.6175972978326200610.git-patchwork-housekeeping@kernel.org>
Date: Fri, 09 Jan 2026 17:56:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] mtd: spinand: Octal DTR support (2026-01-09T17:17:59)
  Superseding: [v1] mtd: spinand: Octal DTR support (2025-10-31T17:26:45):
    [01/28] spi: spi-mem: Make the DTR command operation macro more suitable
    [02/28] spi: spi-mem: Create a repeated address operation
    [03/28] spi: spi-mem: Limit octal DTR constraints to octal DTR situations
    [04/28] mtd: spinand: Fix kernel doc
    [05/28] mtd: spinand: Add missing check
    [06/28] mtd: spinand: Remove stale definitions
    [07/28] mtd: spinand: Use standard return values
    [08/28] mtd: spinand: Decouple write enable and write disable operations
    [09/28] mtd: spinand: Create an array of operation templates
    [10/28] mtd: spinand: Make use of the operation templates through SPINAND_OP()
    [11/28] mtd: spinand: Convert vendor drivers to SPINAND_OP()
    [12/28] mtd: spinand: macronix: Convert vendor specific operation to SPINAND_OP()
    [13/28] mtd: spinand: winbond: Convert W25N specific operation to SPINAND_OP()
    [14/28] mtd: spinand: winbond: Convert W35N specific operation to SPINAND_OP()
    [15/28] mtd: spinand: List vendor specific operations and make sure they are supported
    [16/28] mtd: spinand: macronix: Register vendor specific operation
    [17/28] mtd: spinand: winbond: Register W25N vendor specific operation
    [18/28] mtd: spinand: winbond: Register W35N vendor specific operation
    [19/28] mtd: spinand: winbond: Fix style
    [20/28] mtd: spinand: winbond: Rename IO_MODE register macro
    [21/28] mtd: spinand: winbond: Configure the IO mode after the dummy cycles
    [22/28] mtd: spinand: Gather all the bus interface steps in one single function
    [23/28] mtd: spinand: Add support for setting a bus interface
    [24/28] mtd: spinand: Propagate the bus interface across core helpers
    [25/28] mtd: spinand: Give the bus interface to the configuration helper
    [26/28] mtd: spinand: Warn if using SSDR-only vendor commands in a non SSDR mode
    [27/28] mtd: spinand: Add octal DTR support
    [28/28] mtd: spinand: winbond: W35N octal DTR support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


