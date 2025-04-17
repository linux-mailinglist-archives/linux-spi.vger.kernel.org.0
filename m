Return-Path: <linux-spi+bounces-7644-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFADA92214
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 17:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336EA178DC8
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 15:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE8A253330;
	Thu, 17 Apr 2025 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZGk9oFF"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3C1145323
	for <linux-spi@vger.kernel.org>; Thu, 17 Apr 2025 15:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744905415; cv=none; b=OQeRl57Ge0UXHXUhfyjcziVEtCTca/rx//GJgX5u4OrgCziHiYIyOCPMBpZFnoYxi6Br8Kh+WbRcrH78Zlj8HRTFVmwMhOdCVNoXyEX7YHhfwLLlw2k1mN/hnGVWsLxlHE3M9ntGAEOTd/xUrcalgTfCnslDryizNjeOt1vGRC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744905415; c=relaxed/simple;
	bh=vqkjlq+4P4ArL2MWXgP1zZhrf/CZ/ySNU2ej3ohSM9w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RzFDT5i22UNDqmfr0HJ+UfDTIgbBHtsX6gtCagmGGf4vOi/jKeEhy/U8M5WI3qSpVV8lRqQ6eTwioRd8mGbshiRnw0R/Jvxb0ypO7PLEUtfXJ9iviS2tvc88FJTp5BgjHxI4MzcRMB5xPDEAIYpcI1FTDBOd6nSKmad5cmFKMjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZGk9oFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30014C4CEE4;
	Thu, 17 Apr 2025 15:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744905415;
	bh=vqkjlq+4P4ArL2MWXgP1zZhrf/CZ/ySNU2ej3ohSM9w=;
	h=Subject:From:Date:To:From;
	b=YZGk9oFF3ATw68ahZaMc6BpUk2Js1p1AQcdYsgJoWgo7dng8Lg5uhlGJtLbH/Azna
	 XkvsiDA3MjbJ735r9q49OanGnnudmsZ7eehBWf7zGrECL5asNC9MhtlIIAIPZTlG+R
	 fBzaQ1c08bh9t+5yJxtEnLzt6V7KFZN7gKTi8W9iO6xBQY40qZm8t327uIBMAqMdfe
	 pCafQYiObWLmB2BuXaRLSnUQ6SHsnsItmejanO7rwbxNtrRcFJaHgVuOmH7LAAGy27
	 zQghmUmlgOBF+g7LXKuCnl268kFq4cVG4Xo7ajHPIjRIaM7mf0rayJScpqVeZ4ymwQ
	 fDOTe/vHTKxZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71027380664C;
	Thu, 17 Apr 2025 15:57:34 +0000 (UTC)
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
 <174490545312.4124714.15644412200637151641.git-patchwork-housekeeping@kernel.org>
Date: Thu, 17 Apr 2025 15:57:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: Introduce and use spi_bpw_to_bytes() (2025-04-17T15:24:46)
  Superseding: [v1] spi: Introduce and use spi_bpw_to_bytes() (2025-04-16T06:16:33):
    [v1,1/2] spi: Add spi_bpw_to_bytes() helper and use it
    [v1,2/2] spi: dw: Use spi_bpw_to_bytes() helper
  Superseding: [v2] spi: Introduce and use spi_bpw_to_bytes() (2025-04-17T15:17:51):
    [v2,1/2] spi: Add spi_bpw_to_bytes() helper and use it
    [v2,2/2] spi: dw: Use spi_bpw_to_bytes() helper


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


