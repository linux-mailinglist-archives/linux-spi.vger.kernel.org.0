Return-Path: <linux-spi+bounces-9649-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6237DB32B2F
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 18:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31DCA174D1B
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 16:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3A86BFCE;
	Sat, 23 Aug 2025 16:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOzjBQgb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA511F419B
	for <linux-spi@vger.kernel.org>; Sat, 23 Aug 2025 16:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755968204; cv=none; b=V1mOjCu7xXpKcdQrEoynCHqytEfEriI4RHa9sbQFPQORDZok8qWp+BfAyYH9SDNuOp/PtuWrmFV7wN5vqBXqQ4Nsy88x7XUi8izUSP+05Tv2eoCNEvwr0mVB6lolVcs227SKhn9C8E4pOmyZx+gFIW2VNH+WOsBBrqCcQcYlDiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755968204; c=relaxed/simple;
	bh=yQ/9tuJn0KdybXHEyS8RGziSFo9rRzzMdDw6Dmp/EOg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VnHRjqhd97DO28xFPYGOIdGEZYfIrrbSpH41YeiRNi6NidsNAJildfnpZf/C0jV8YxtHklgkfqiILQhY/cW6PnwNi6bvxiBqBzxBJyqmJzHc4wgO3lG9OYbaiEwo+/U2S1VHl2jMRPGXxH34rk2WHM2YqvuFNHepsE5Q885FZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOzjBQgb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16F9C4CEE7;
	Sat, 23 Aug 2025 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755968202;
	bh=yQ/9tuJn0KdybXHEyS8RGziSFo9rRzzMdDw6Dmp/EOg=;
	h=Subject:From:Date:To:From;
	b=NOzjBQgbSIqNwsoBbUmUOjQu7tUhpkRE4ib5p0/yfnTffDyq+f0GYojroyFo/SLQB
	 wOlC2iDBSCG0kVlZM8BVPGiUaFTPITHQgAWoQpLlyZT4DUNcAlFZvbJALo/gUou4eY
	 maOhka+PdtUB30WnQvmzEddnIT7FwpcQV7VbTgH4MEQSwZgcxp8ekOccDUXqtGnVxq
	 5loG3MvAzPpXw0Zq+xzBd8RXeHjPLghaYAf7JqYf5OfEhDqmv3qfnI+4Zt0nSy5daT
	 nmg5eW8tqlp4ZFARVWupDyIqxqyEOteWAQ04Us5NMGB2xoL1SUU92MeS8Xi5+rJkYG
	 DoPz8XGarZ33A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CBD383BF69;
	Sat, 23 Aug 2025 16:56:52 +0000 (UTC)
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
 <175596821116.2217754.5796389433492814553.git-patchwork-housekeeping@kernel.org>
Date: Sat, 23 Aug 2025 16:56:51 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: airoha: driver fixes & improvements (2025-08-23T16:01:03)
  Superseding: [v4] spi: airoha: driver fixes & improvements (2025-08-23T00:16:13):
    [v4,01/13] spi: airoha: return an error for continuous mode dirmap creation cases
    [v4,02/13] spi: airoha: remove unnecessary restriction length
    [v4,03/13] spi: airoha: add support of dual/quad wires spi modes
    [v4,04/13] spi: airoha: remove unnecessary switch to non-dma mode
    [v4,05/13] spi: airoha: unify dirmap read/write code
    [v4,06/13] spi: airoha: switch back to non-dma mode in the case of error
    [v4,07/13] spi: airoha: fix reading/writing of flashes with more than one plane per lun
    [v4,08/13] spi: airoha: support of dualio/quadio flash reading commands
    [v4,09/13] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
    [v4,10/13] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
    [v4,11/13] spi: airoha: set custom sector size equal to flash page size
    [v4,12/13] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
    [v4,13/13] spi: airoha: buffer must be 0xff-ed before writing


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


