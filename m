Return-Path: <linux-spi+bounces-5134-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CE4993BFA
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 02:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA271F21B00
	for <lists+linux-spi@lfdr.de>; Tue,  8 Oct 2024 00:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8A6AD5B;
	Tue,  8 Oct 2024 00:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLJMTpRF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFFBA94A
	for <linux-spi@vger.kernel.org>; Tue,  8 Oct 2024 00:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728348968; cv=none; b=d74bQInsisgDCfBA4RRbDEZst9WFPAlYu3kyIsXlomHcuJ2p7IZ6WK/c5JEpr7VjbX7yrn56kdwS6mLDbu5eHdnfD+yu647r5cmjBhM0ebqWBVShS3bGKMEFakayGjR8r/UQbL9LHMREls68Y7+nd1+4xBijZ1whRdZ7jEwenGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728348968; c=relaxed/simple;
	bh=Dl5hvMoBpoI4L5jdXeTRrAOcrER8HaMY7pJPjvEUNWw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=hdtZvCqJmyUpOsFFCrQMDySC216q7fGYZK63HWOBA7YBC3I0cLRz5O+NQg127pb6VYDrDQ44I1uphKk9PvHeylTlTSaTNeh5jKPfGcSvuoHseODRPCP8bBUwZ282E/k2ZVGShb3qDLejwaFv9c2LZ9ty30q2A7EAiew8TgjSS/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLJMTpRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5850C4CEC6;
	Tue,  8 Oct 2024 00:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728348967;
	bh=Dl5hvMoBpoI4L5jdXeTRrAOcrER8HaMY7pJPjvEUNWw=;
	h=Subject:From:Date:To:From;
	b=VLJMTpRFaZGG9vic2+QktMLfrx774QBTq7Csxn3BTorH2mfuPWpHvVZkH29ITHS4V
	 AZWm293FRcjtgIma34Bnwb8hABo/5DSVF4BgJgKlrMOsstcde74vGEo3iiQ8QRPpR0
	 HGOs+vGvV5aUB0mHmEpLHRXFT5zQdPoihou2UNjOb3Q8rE6CqGd4X99BpzgMNLVzZ3
	 uj1DAr1/LMPUXCBA/JZBjGHXPS/JoGAPqubUX63XEdeBlbanqmLzgqovRmxGOdkpjr
	 aHbyNn05AbLFEH4poQQY8GyviT2dC52Z/gh32NJ7zOfWb3jf14UEcVWtD5TEI9SeBE
	 r7ds0XS0KW9IQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C213803262;
	Tue,  8 Oct 2024 00:56:13 +0000 (UTC)
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
 <172834897176.34489.15544541588314170232.git-patchwork-housekeeping@kernel.org>
Date: Tue, 08 Oct 2024 00:56:11 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Realtek SPI-NAND controller (2024-10-08T00:23:06)
  Superseding: [v1] Realtek SPI-NAND controller (2024-10-06T23:33:46):
    [1/3] dt-bindings: spi: Add realtek,rtl9300-snand
    [2/3] mips: dts: realtek: Add SPI NAND controller
    [3/3] spi: spi-mem: Add Realtek SPI-NAND controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


