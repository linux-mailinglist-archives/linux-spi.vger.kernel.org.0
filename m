Return-Path: <linux-spi+bounces-6122-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C1C9F790B
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2024 10:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067FF1894D09
	for <lists+linux-spi@lfdr.de>; Thu, 19 Dec 2024 09:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507D2221476;
	Thu, 19 Dec 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfmuEzwl"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C092221473
	for <linux-spi@vger.kernel.org>; Thu, 19 Dec 2024 09:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734602206; cv=none; b=JQCv0ggOORGexBf/Lc3R4ZQNrH59G5kjjrPVLmzpAFfolH+MGwf+I4UlcdAPDxHEp4Gw0+C2EdpKXn5Dfg2m/koDhlCf7Bm1RZS/gP3WQHXs2omoDrI/Tj/mKCn5guO/h8L95RJDyHpJqoThBcGL7WafCOLUyzif2wprF4BydpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734602206; c=relaxed/simple;
	bh=wncMzih1lDyVkINgPPBrb8tjhEKqPQwcunTdk8QX4bo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=OPxqxKL4Kan3/Y2z2JrXPiVFwJFaOLn3h/31dOiui9K8pc3hd9J2JpHggBCW6QqYOsXiBusnNfts2hhwY7PTMHuab+QNTzq1lfCCULw62e3qP4kmbL+S+AMth33Sp8f8Ig3FTctwVrJPYyAmP3jT8V0GXrKgKXTsCUf7+QfrlOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfmuEzwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB534C4CECE;
	Thu, 19 Dec 2024 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734602205;
	bh=wncMzih1lDyVkINgPPBrb8tjhEKqPQwcunTdk8QX4bo=;
	h=Subject:From:Date:To:From;
	b=RfmuEzwlmku6XnZH+Ow4Uhn5EcqmXKq+l6HAzcRdfR1Gl0gwUxK+YcltF45qOlMhu
	 4oFgDXoCLC3xBRiu/H/aM9eI0M9glj7dN9Ys5IpSxDKc9ra8zC3mKhpzEEfB60fcJe
	 IZzxy0TCeHHmvqkO8m4hsxPJ1lLysCOLBYJt+DhEYHMPXJGUlXn+uXoOZiyj1+y69e
	 VArq3QhsEUablmA7ScrDP310G8xR9rYhV31Kh7Lr0ujm6nKlu2gpSt2vYZQ8Vtm3XU
	 p0a7tdqmNEcAeEwBEm/y8hQsM0st6WYs1GCwoIU9VSvL6U67eUfF44GeUlABWu8dcJ
	 EvbnsQkNRfecA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE73806656;
	Thu, 19 Dec 2024 09:57:04 +0000 (UTC)
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
 <173460222306.2201273.11746211663854498049.git-patchwork-housekeeping@kernel.org>
Date: Thu, 19 Dec 2024 09:57:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: atmel-qspi: Memory barriers after memory-mapped I/O (2024-12-19T09:12:58)
  Superseding: [v1] spi: atmel-qspi: Memory barriers after memory-mapped I/O (2024-12-18T16:58:49):
    spi: atmel-qspi: Memory barriers after memory-mapped I/O


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


