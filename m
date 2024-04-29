Return-Path: <linux-spi+bounces-2612-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D8A8B5E3C
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 17:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7D5281620
	for <lists+linux-spi@lfdr.de>; Mon, 29 Apr 2024 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD4F839EB;
	Mon, 29 Apr 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P54pnJIs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95397839EA
	for <linux-spi@vger.kernel.org>; Mon, 29 Apr 2024 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406202; cv=none; b=Rw3TAxmIyHO277No9gQVn61Auh5kktsvmjFHmUcbFnHeswscZSzK9SKFZTBSTWzI6nmqhKBECzveOH3pB+wmUmM+sOjo5oRiMdcjVyMAnPn71A23SSVbb3P+c3GcfJNXaek+XPvjqqNcKai8qZFZIe9odLUHapK9BSTe5WL7rdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406202; c=relaxed/simple;
	bh=WqpkmHupJ2y6jUG2DQh3zvdo7TOCMxUPM2zpGcWQ0+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=NkuqkIsiIXETy9I4PMlKxQ9jE7TO6bBc06aXY2IoMlbj83L4kGcHZDXGjjaTDxC76AZo5eE1ktflWMOVRSYk4J1+JloTEndQviM2812vvjuZYm3H+LSkaZON1GWtEJ4CkPbKxIzNdlUXRnvk8q9IRQPcZkdHgGCes+iBPlvXw3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P54pnJIs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 225D2C113CD;
	Mon, 29 Apr 2024 15:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714406201;
	bh=WqpkmHupJ2y6jUG2DQh3zvdo7TOCMxUPM2zpGcWQ0+k=;
	h=Subject:From:Date:To:From;
	b=P54pnJIsMmBX766ad6L1I8nvqN1ptxZ/skEqHWeFq5EmOf5lAaY4nd3aKzDWCbWNg
	 3QPtGbcUEZKK58mXW7QA/CdBPWAw29Q7xN54xN7vhW7OgGGe8jtNR4jfGe16bOM0hR
	 fk1YkZ2TTANJjhQhTOwsrW/ZwrarVT1mKceRCTbB7MFR+4OSOu+aaYLuIFGPjyGYQs
	 V8ZabbvDA1uPxTz4LhiOtk3rr2OPPCKyVZAs5gv0rbX5M/WDnlbRA1xnkTSy+WnXW6
	 0SUl9vjW8WrkAxv6P7A7zaBq3fYKm4qWBf9FyefjKuA3wgCQyu4rZgtu0APuNPK0sE
	 aRKDN+e0pF4Uw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D2E4E2D48A;
	Mon, 29 Apr 2024 15:56:41 +0000 (UTC)
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
 <171440620105.23934.2766852779590075989.git-patchwork-housekeeping@kernel.org>
Date: Mon, 29 Apr 2024 15:56:41 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: dt-bindings: ti,qspi: convert to dtschema (2024-04-29T15:44:21)
  Superseding: [v1] spi: dt-bindings: ti,qspi: convert to dtschema (2024-04-28T06:58:59):
    [RFC] spi: dt-bindings: ti,qspi: convert to dtschema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


