Return-Path: <linux-spi+bounces-2483-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AE88B08CD
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 13:57:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF0A1C2381B
	for <lists+linux-spi@lfdr.de>; Wed, 24 Apr 2024 11:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6654315AD85;
	Wed, 24 Apr 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqQv97/X"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C04158DDD
	for <linux-spi@vger.kernel.org>; Wed, 24 Apr 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713959794; cv=none; b=e1YE/Prz97hV/4887SSzoTpkiT/DpBuww188NtWzCaBUQwEaDy1SPaePTGEJdSoEsqk9pzyK+0lIZjXCeKj8UcLwvmTP+4U4hOgHQ8zbsQmpV2XSFkNVvI4E71BYkfsaxnkjIVbjG4EcqVv5GfGyr7X7ZDDHtz+4eAqoHNZQJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713959794; c=relaxed/simple;
	bh=nLJyKF1SiMX1y1w0MdzH6s/2iQwQwPgV72lweol3wvY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=PJ/Sxh7VZg6WZJH/yMsvmegbF3TsoQ/6a/adctD+A5Uoqz9y6n0x82C+Paib6bK5CuRFOuRvXpN5UlXIqMQUi1zWaaRNN0H60MmhcCJ27phfFKcRlkcj0EJEyEh8z9TM+/aDnUde115h5Cm5PKDjTW+Q690Z26hIFufj0GXC2QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZqQv97/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0BC7C113CE;
	Wed, 24 Apr 2024 11:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713959793;
	bh=nLJyKF1SiMX1y1w0MdzH6s/2iQwQwPgV72lweol3wvY=;
	h=Subject:From:Date:To:From;
	b=ZqQv97/XDTAe5XbyqbJRgSQ7YFPrEWJKIwWKCdSmzBGLnSBXbMWs5CdoRSqSbU2Ar
	 3vG+alQ45X25beXBksbvddC03JJA7oj8JYGK968roTgdp422eHJRw2Mb+i7X1MKQb9
	 8Rg6YmV+iQdw8EZ84+kzF6PTVOZ+XNQllUeMfsymshTYANIa3OH9HS6ACk4cchBRSh
	 ulLHswITfeQyijtZcdt+hk1M4ZYmoDvGRBqRIHbpwQDAkiwtXrNW5p7kcj0WEnjGFR
	 m0HErCVWcfez1oy0BtlYVHinjfj1oYl1NdrRN6MA/MYA6YEU9t1mFux6QQucF/+PuZ
	 5CNsqAtWeth7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9AB23DEC7E3;
	Wed, 24 Apr 2024 11:56:33 +0000 (UTC)
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
 <171395979362.4549.12562148372356682095.git-patchwork-housekeeping@kernel.org>
Date: Wed, 24 Apr 2024 11:56:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: mux: Fix master controller settings after mux select (2024-04-24T11:16:47)
  Superseding: [v1] spi: mux: Fix master controller settings after mux select (2024-04-22T11:41:50):
    spi: mux: Fix master controller settings after mux select


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


