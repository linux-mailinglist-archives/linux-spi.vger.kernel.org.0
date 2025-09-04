Return-Path: <linux-spi+bounces-9909-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B95CDB43F2F
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 16:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7546A17735A
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 14:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6D0338F4B;
	Thu,  4 Sep 2025 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uLHwLgRr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64413218C9;
	Thu,  4 Sep 2025 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996558; cv=none; b=P45u0BmA+8i+4mLP+LALId2ZRtw2uDrbmAUOGzg3WplwFgi0aEw+bol1Eb2+aDwyx3aWzfw1lz2J3IGeWbhyJoxM8dP8iol5f25J6zbKDULc7iHKslby0T+3O2VOln0i7Wue1a3FH69QdCZ9vWuP492TxlYujld6C+v3EvNk/FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996558; c=relaxed/simple;
	bh=PP1vNfr679OyVekRZnMjNH8sTtGmlERTNSRR8TTURCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FvPgeBBUgifywFV5lpTHfhS2JEYmhKWEXSYCrr5YmrrcDoi05MTtVbtunbLapi9VFxGtLsqo3IY7QRhRsP9zHlVhuKIEyIqPG9HxmbtkntAWyZpCJjXIbyryWCZTT7eURLFsyWjOO5wh4mB42Nu7JyG0IPej50iMDeta0aHuDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uLHwLgRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4CCEC4CEF0;
	Thu,  4 Sep 2025 14:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756996557;
	bh=PP1vNfr679OyVekRZnMjNH8sTtGmlERTNSRR8TTURCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uLHwLgRr5YUcmI5q3NicS7id5deaPjh/DWl0WLxLjuGb6EqlrCL7CXTx1HcNzCn7E
	 2yo4/coNkqMJvWqnJyCqJWMXTGyhzsSe/LNw+w5Gc/J/eqifBEGENvpyiro0+Jt8Mg
	 +dM/EK8Jqt0uQmIboSVs/YeQOyKZTQs4rvYK92nzcJeR5UoznQ/tWPEGVsto8CEvYx
	 9eKmPCR+82e9wasvPNxYD3alBBtmDRQen3SgK7KxYKzYppLO97WCKbUj3PWBidexjM
	 RPiUfoJhXMYHkG3/ricE3qjj/aUQLof3wlEtzSVjlxOwEkOBhvN/gX9cF08MGD4EWh
	 8nRzv7Qn9PBJQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <miquel.raynal@bootlin.com>,  <broonie@kernel.org>,  <vigneshr@ti.com>,
  <marex@denx.de>,  <computersforpeace@gmail.com>,
  <grmoore@opensource.altera.com>,  <theo.lebrun@bootlin.com>,
  <linux-spi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <praneeth@ti.com>,  <p-mantena@ti.com>,  <a-dutta@ti.com>,
  <u-kumar1@ti.com>,  Pratyush Yadav <pratyush@kernel.org>,
  <stable@vger.kernel.org>
Subject: Re: [PATCH 1/4] spi: cadence-quadspi: Flush posted register writes
 before INDAC access
In-Reply-To: <20250904133130.3105736-2-s-k6@ti.com>
References: <20250904133130.3105736-1-s-k6@ti.com>
	<20250904133130.3105736-2-s-k6@ti.com>
Date: Thu, 04 Sep 2025 16:35:53 +0200
Message-ID: <mafs0y0quthdi.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

On Thu, Sep 04 2025, Santhosh Kumar K wrote:

> From: Pratyush Yadav <pratyush@kernel.org>
>
> cqspi_indirect_read_execute() and cqspi_indirect_write_execute() first
> set the enable bit on APB region and then start reading/writing to the
> AHB region. On TI K3 SoCs these regions lie on different endpoints. This
> means that the order of the two operations is not guaranteed, and they
> might be reordered at the interconnect level.
>
> It is possible for the AHB write to be executed before the APB write to
> enable the indirect controller, causing the transaction to be invalid
> and the write erroring out. Read back the APB region write before
> accessing the AHB region to make sure the write got flushed and the race
> condition is eliminated.
>
> Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")
> CC: stable@vger.kernel.org
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

IIRC I wrote this patch a few years ago when I was still at TI. Nice to
see it being upstreamed! It feels strange to review my own patch, but
FWIW,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

