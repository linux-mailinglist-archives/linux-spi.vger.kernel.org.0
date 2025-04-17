Return-Path: <linux-spi+bounces-7651-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD8AA92CD6
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 23:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A354A0EE0
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 21:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BFA1FC0F0;
	Thu, 17 Apr 2025 21:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbHZAj2V"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3CA1CEADB
	for <linux-spi@vger.kernel.org>; Thu, 17 Apr 2025 21:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744926594; cv=none; b=RDpzcDWQtKzWASUQ8PkpogZMIjE8Bxk6P5nRUq3MJrkjEI+rYqUszciL+jiVB0i5JXDJXE5xiPBwhcL+LgymscgZ3eBQDK7r3sp9/xmLOf9z+yATgBiAZW4mhMzSTkBpqOicR6WMMIwNnXedblFW8OiA9qTdOoMS1tcLwRNr+6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744926594; c=relaxed/simple;
	bh=+WSzQ4NiGgeJwQptbwxS8Sx6xLhj0LNhTvuK5RKFv0Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RBoXQ6/EiVQBIMS2i6gEWMUxVEEW1CNUSxQa8cz8cNTTc/HR15jIjX4ATcqpZw8VF5Wg3hJDR9cgQPJDtVGmoI6h0U0XBCepcsgYVX7M1LrGbXY4FPbHiz3Lbqkvs0y56adQliVq9J1P9ldLHtHee6PMorFpPSuKllwlTL3y4DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbHZAj2V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89168C4CEE4;
	Thu, 17 Apr 2025 21:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744926593;
	bh=+WSzQ4NiGgeJwQptbwxS8Sx6xLhj0LNhTvuK5RKFv0Y=;
	h=Subject:From:Date:To:From;
	b=QbHZAj2VAC4/q3TmUAQz2fVw5epJuJdpHPJ9w+PDYeNNno9DKjlxBkvKrUZGAVYwF
	 lBblDWOiymYukC2G1XZkKCtUJAid3cjLjV4dh3PYmA4wl6jfdUPH+frXLFnrAWdjGn
	 wAXgaeV08q8w2Ea5CUcLWiE17IAmJYXQhgaOgiItCQsBsvsND0t+jQozDLigJSgX07
	 adG+R6s4GWbkpdCNaNeQkwJJQ6ELOzqP4s9ZGvEmPJ9u9aa3NSDHIhS5+lwQE5KZm1
	 DNbDJkn+ivFVwPIT+C0fIed3kQRONAthZfHOcKbn8CvTFy4g7TZ71wcBrI5O3oISN5
	 7sacHHTlwUuaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B2C54380AAEB;
	Thu, 17 Apr 2025 21:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <174492663133.27568.5862581343132075413.git-patchwork-summary@kernel.org>
Date: Thu, 17 Apr 2025 21:50:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/2] spi: spi-cavium-thunderx: Use non-hybrid PCI devres API
  Submitter: Philipp Stanner <phasta@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=954346
  Lore link: https://lore.kernel.org/r/20250417083902.23483-2-phasta@kernel.org
    Patches: [1/2] spi: spi-cavium-thunderx: Use non-hybrid PCI devres API
             [2/2] spi: pci1xxxx: Use non-hybrid PCI devres API


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



