Return-Path: <linux-spi+bounces-9910-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1760BB43F3F
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 16:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 346267BF917
	for <lists+linux-spi@lfdr.de>; Thu,  4 Sep 2025 14:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B857322556;
	Thu,  4 Sep 2025 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YusnVBW3"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E241C321F59;
	Thu,  4 Sep 2025 14:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996588; cv=none; b=lD5gzgRuBe8cK+7uKiMDNvsbx4UV8EaXFQYfMrAn5cUulavabARX52ByvbRBL02bWNzr1AAP6kchvaws5hLjBAwkdpbkeMbTm/tAouRke59a9r1k75/raZXe35gzjUszAt8O7U2yrgp5SWl39dJb18/esnnd2nb6fCWcj36x7U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996588; c=relaxed/simple;
	bh=ozx+RH6touGKnITr2UNCEuP987PD7jBqjfOVoDVKJuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CaTtZZF3xr6zU2YqmTyrV51aztcVGwS1Ff6kj/xbg6sAxEamn2OyEXFnz9dIx7WTpyemM7cODOsjgn4JjcomW3Xch/HB2EDGuYieX0Jlvq0ZVAccGN2EFekDM9Xhcp38pKcE8FS8hLugnmQjTxN84nh831gWSotwyr3EJVu1Yns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YusnVBW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18075C4CEF0;
	Thu,  4 Sep 2025 14:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756996587;
	bh=ozx+RH6touGKnITr2UNCEuP987PD7jBqjfOVoDVKJuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YusnVBW3rIwLL+tTh4HXcG66Ne6hIE1eup25E/jWDrboS3qBIKOicSwg5M7JNNYDi
	 5Po4kllo8zC1cBnqABuYmmEBJ2GIJmyE2S+oa737RogVLV/IXCJCBpMdXScBzUmhaj
	 W8v6oqoxwrR/eu2SJRgqv8vqQ26fahsu0YI6/Hc0gQ3DCAIBAfRGc84VvUiepN38oR
	 kt0zsmaOowSBwaDXElBZMsH3EQZ3LGrH//IqWuNGpD/B/dJ3GKvO1t0QOJikMPlGPE
	 yOXIqKW9BUxIhYdKYj/ta5nOamMb7QWWMFkBWXLk8AVRKKYA8sQV1Rd4+RufOrcbcw
	 cxU4DWvDmVuHQ==
From: Pratyush Yadav <pratyush@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: <miquel.raynal@bootlin.com>,  <broonie@kernel.org>,  <vigneshr@ti.com>,
  <marex@denx.de>,  <computersforpeace@gmail.com>,
  <grmoore@opensource.altera.com>,  <theo.lebrun@bootlin.com>,
  <linux-spi@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
  <praneeth@ti.com>,  <p-mantena@ti.com>,  <a-dutta@ti.com>,
  <u-kumar1@ti.com>,  Pratyush Yadav <pratyush@kernel.org>,
  <stable@vger.kernel.org>
Subject: Re: [PATCH 2/4] spi: cadence-quadspi: Flush posted register writes
 before DAC access
In-Reply-To: <20250904133130.3105736-3-s-k6@ti.com>
References: <20250904133130.3105736-1-s-k6@ti.com>
	<20250904133130.3105736-3-s-k6@ti.com>
Date: Thu, 04 Sep 2025 16:36:24 +0200
Message-ID: <mafs0tt1ithcn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 04 2025, Santhosh Kumar K wrote:

> From: Pratyush Yadav <pratyush@kernel.org>
>
> cqspi_read_setup() and cqspi_write_setup() program the address width as
> the last step in the setup. This is likely to be immediately followed by
> a DAC region read/write. On TI K3 SoCs the DAC region is on a different
> endpoint from the register region. This means that the order of the two
> operations is not guaranteed, and they might be reordered at the
> interconnect level. It is possible that the DAC read/write goes through
> before the address width update goes through. In this situation if the
> previous command used a different address width the OSPI command is sent
> with the wrong number of address bytes, resulting in an invalid command
> and undefined behavior.
>
> Read back the size register to make sure the write gets flushed before
> accessing the DAC region.
>
> Fixes: 140623410536 ("mtd: spi-nor: Add driver for Cadence Quad SPI Flash Controller")
> CC: stable@vger.kernel.org
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Same as the previous,

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

[...]

-- 
Regards,
Pratyush Yadav

