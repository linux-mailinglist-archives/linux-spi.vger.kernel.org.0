Return-Path: <linux-spi+bounces-2824-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 426E08C2FF4
	for <lists+linux-spi@lfdr.de>; Sat, 11 May 2024 08:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2703B2361D
	for <lists+linux-spi@lfdr.de>; Sat, 11 May 2024 06:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C513EC2;
	Sat, 11 May 2024 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIIUWXvP"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DE3D531
	for <linux-spi@vger.kernel.org>; Sat, 11 May 2024 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715410619; cv=none; b=PDUwk58CCOvOiC/dsm4VUX83qJ9ENBIktkxJLh3trE9OrqHgpzREMl6tugCjd4do/PiXiY9VzqUTu9yUyeUXuTAufLIJIEA/WppR1FP4EyCqs/8wrk91nBm2eJO+e/dVPQjl9ClGY8eGMcAmSbHM/WECvnPcIsZov5kX91O7YVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715410619; c=relaxed/simple;
	bh=zK9ndOm46LFuzWe+Y9wIyXs58OSFb05AIRlgoBdR/Y4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VtsS+Vlse56SJt/wYYmF1WEhO8KUKFRjkYSoFdBZmaoAKFqXrQAmlkGHmo1pHi3yvPHzLqVV9xs3X8kDVYQB6n+WjLDZroRpdAlTk38dtpdL9duR1eduFfhXHAAtTiUdyqdXSKTMBF7fVifHEObjacNZZ1tSY3+BpnA7/h4N7RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIIUWXvP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9B11C2BD10;
	Sat, 11 May 2024 06:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715410618;
	bh=zK9ndOm46LFuzWe+Y9wIyXs58OSFb05AIRlgoBdR/Y4=;
	h=Subject:From:Date:To:From;
	b=iIIUWXvPbhD80KfcGmAC8HVQkS9+4s2esfff7MxntbNiMsUBxhRh8OCjk7HfQ7FxD
	 AS7RAp6WWGzIyjJiDgxznAQavoYMaHPTOku8vERUwrVr9V2wyGtTrTVHgJcoym3tvi
	 ieQRI8coWB1lYVYFQjDO+GisIubYzoP4rGMAIKQFKfoJJAna56PuwjXrHGKZSs2+tE
	 a7XR8k+v9SvBxGQZNGqOuZHkBYOljVtVrFM12++Qfco6bQXu3jgQFGs2YDQGBUe1GY
	 48IS4PsFpVbCGc4uucwFda3HKgkFkZb4KUXHB4RH28yd6yrXhZqteVpWUarLq4Sp6A
	 F4wk5GisIrjGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C01E1E7C0EB;
	Sat, 11 May 2024 06:56:58 +0000 (UTC)
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
 <171541061870.5845.9228310288370183943.git-patchwork-housekeeping@kernel.org>
Date: Sat, 11 May 2024 06:56:58 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema (2024-05-11T06:14:56)
  Superseding: [v1] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema (2024-05-09T14:34:58):
    dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


