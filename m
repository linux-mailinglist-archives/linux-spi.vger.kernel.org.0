Return-Path: <linux-spi+bounces-9546-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B77B2D75F
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 11:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 485F858279B
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 08:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D43A2797A5;
	Wed, 20 Aug 2025 08:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2tczAXH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A1B24339D
	for <linux-spi@vger.kernel.org>; Wed, 20 Aug 2025 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680215; cv=none; b=hxBu7UDZHTPCu1N7tO+cgx6S/7J6oYqLI9gNQsacauo8JNoNy7lFyO5j47xxh5tkUJgha/+dK7pQ8kRtbzo9o70kD9j6kUzRF91iF9uvFQ5o4gOTiTscOEDG1dMGKMicoTTL95VQjQSzNnU7rH4hqOSwF3nQwm5Dxe4LeK255HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680215; c=relaxed/simple;
	bh=JmQUQ80k7Rkwq4Zs6JuibyhzfUFSaXaSK0ICe1wZj7s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=f9d4yNhEipdLqgsmPXpdxGe3u+wRulcZOq3BCeM0OrK0oAGB5y62l1cGZYrk2b+hrUb8c2m8UrbUWSO1EV+yu1mGoeNGwKVL5EnEN4UPqzvB6ZCbLnuw6WicNzuRTbLylddvYZ5qV6jQoKDM9YIac0SiGZ6ZTM4uU83f1ZKaN/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2tczAXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9992AC4CEEB;
	Wed, 20 Aug 2025 08:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755680214;
	bh=JmQUQ80k7Rkwq4Zs6JuibyhzfUFSaXaSK0ICe1wZj7s=;
	h=Subject:From:Date:To:From;
	b=U2tczAXHuBzybIx29pMaL+NbOTQNg7QtowcYKIyJ+UQ6koYoReRN6FvKWJ3uLdwv8
	 mV02NzSBRBJMae68w/Kr+og4NlgcuoRwHlm0cZPM/80TUxcx28a4qyqGi1pfURAi+R
	 bDixwWZVlff47KyYga0uz9BZ6KgrYST0Fs9+4d5+DgrAvBrvr9ORIrQfLLa4JDLMnf
	 12J04qrKnN38yHgix+SGRx7yTqGxVDHmfNaWOfZa2Lok6san1lMR6c+hQ79BB426Al
	 Dfz2alDsWvRFDl6rGhYb17Y31T2VOBe1Vr1lorZbhEeRucf9W1lWP3nrUa5tD4ttrq
	 A4YVWW5EKy8zw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CCB383BF4E;
	Wed, 20 Aug 2025 08:57:05 +0000 (UTC)
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
 <175568022402.153053.5098182880219759211.git-patchwork-housekeeping@kernel.org>
Date: Wed, 20 Aug 2025 08:57:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Virtio SPI Linux driver (2025-08-20T08:49:42)
  Superseding: [v8] Virtio SPI Linux driver (2025-08-07T07:29:33):
    [RFC,v8,1/3] virtio: Add ID for virtio SPI
    [RFC,v8,2/3] virtio-spi: Add virtio-spi.h
    [RFC,v8,3/3] SPI: Add virtio SPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


