Return-Path: <linux-spi+bounces-3575-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D8D9166B3
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 13:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91FB028C79B
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 11:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A002014A0BD;
	Tue, 25 Jun 2024 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsQFKPBv"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B55D1494A0
	for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 11:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719316620; cv=none; b=L/gXrt4OR+M33ElPsu6Fa5blJ+syN4hlQJ5AU0rO4qf6fkPzAgH9EKY+BSPA6d6mz5OgsLNrF9geBHleYo44C9n0/rVBlt4DhSugVjyoo4LE8K58EQKcUlIusIzCzOkDjpDa+oQbTsEsWw5vHHCN1YY8poX5h2UKSxiQ/PakW/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719316620; c=relaxed/simple;
	bh=f8sidq02ikPVXn5Dwl72GOR78ZwtFEJ+PUhule87O9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Jk4xe3b2OJq78sBIGhO2PEat3vpNTH8Qb2L7nt8FDurQqVNJrXGyc8IkKL7Yg9PMul9UcfMs2AoYxDCZVyw4BRLVLxBlhC6f1Ta2pj116eylch3jMxrLzgo9xeVLVYYgsUhSBMi5BCwf9gzgUOmcd3MRYAp/5bmZx3mNCUz8N1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsQFKPBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F04F0C32781;
	Tue, 25 Jun 2024 11:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719316620;
	bh=f8sidq02ikPVXn5Dwl72GOR78ZwtFEJ+PUhule87O9I=;
	h=Subject:From:Date:To:From;
	b=GsQFKPBvxg/Nh2XJ+NAUN8h9/bzX7bXiSbjbFw7zMinw6jgf7NOV8jBHzrnVu+fn5
	 9pCnPjjow4kEhFMol3tN4giq4bNlGN+SvZUw47LiRb8YYYPtYohEvrbi/k2x7qhPMK
	 cZhPNz6M7EHpv8UNE337Rk2QqSRasaVHqg7essQ+1wXFYcKPGcn+eERsfXrlsfxev/
	 EfU4gVKMA7XghC+J/2fJ1ejei+G6qlMHbIoEMWU4bG6n6YKCjR2b7udlm872LVBIPH
	 kSlggsJhOakd7//3xBZCMAZ72ctRNRXIjX4Glr1VhLxLqc8+PWe5B/fTQ0c9nf0kVZ
	 +1jRpiqUa1VwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE6B3C43638;
	Tue, 25 Jun 2024 11:56:59 +0000 (UTC)
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
 <171931661977.29269.607746589935037091.git-patchwork-housekeeping@kernel.org>
Date: Tue, 25 Jun 2024 11:56:59 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-imx: Switch to RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS() (2024-06-25T11:22:05)
  Superseding: [v1] spi: spi-imx: Switch to RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS() (2024-06-25T00:20:22):
    [1/2] spi: spi-imx: Switch to RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
    [2/2] spi: spi-fsl-lpspi: Switch to SYSTEM_SLEEP_PM_OPS()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


