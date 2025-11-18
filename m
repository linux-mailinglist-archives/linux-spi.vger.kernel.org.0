Return-Path: <linux-spi+bounces-11275-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E688C69B58
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 14:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 4C26E2B184
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 13:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270773570BE;
	Tue, 18 Nov 2025 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfhralLi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5E734E768;
	Tue, 18 Nov 2025 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473760; cv=none; b=b42ISfLZNPBErn/WYNfz5m8/l7fMxZd60rFJ2DVoq96/fSkjjN8GkqX43A4jGiRfu2Vta3KCiUeUDsy6eyN6Jh9KifizyutWc8LLcVfSl6Ooz2pJNcaWqiJ3eeq/XueI6RiZaTvedTkqjJhTeUu3Wkipbaqt4i/xrOLdileoIX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473760; c=relaxed/simple;
	bh=gBn+zFQ/15OeDuEquI5L05oTTxpfqWVTb/j2583pO9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FcSewlxyREtaQlppa84+TRvDVSWuhXpe2yA+v8ks2fG7oD4FluOyEilcdtnfwOnSSMu36FNiNY+K8dTYHOYoimiAb6uTVm8sRwhwFzqQau9jWrMtYf2GMBRyiLuc4C6nLOrguDoNAZDX8etStvmoUW+PGH7j7258WfFhhlgmnk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfhralLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9A3C2BCB4;
	Tue, 18 Nov 2025 13:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763473758;
	bh=gBn+zFQ/15OeDuEquI5L05oTTxpfqWVTb/j2583pO9o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lfhralLiVKA3NrzOM2K6AZpEGuU2wP1BALvVvGel/zHmTwFyPGmoicmsy5d5XJ2nu
	 87u8QkBk3GvtExEX6XbAhncxOIMf70f+SowSZoiZfaVKaLNNGEv+RBAedSrfxVoD7p
	 uCrM8v8TrD196AjFSByWLfYvXlo0QVsF2hehxxoJVF1Acp74IMJuWSXMeML0zAWmrP
	 874yEha1xPgsEXxICLbaRGhUrWdCucdTyl4siYLYol7Wv3aOqn4HFxzp437N2N4MZ8
	 PJoLrTwa6oJDgDCckE2GoZ5L3UvFJIzCAK5/3euqVZa4nUmBBKElSXgcI1E/3AQvSe
	 ceuSbcMI43F8w==
From: Pratyush Yadav <pratyush@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,  <richard@nod.at>,
  <vigneshr@ti.com>,  <broonie@kernel.org>,  <tudor.ambarus@linaro.org>,
  <pratyush@kernel.org>,  <mwalle@kernel.org>,  <p-mantena@ti.com>,
  <linux-spi@vger.kernel.org>,  <linux-mtd@lists.infradead.org>,
  <linux-kernel@vger.kernel.org>,  <a-dutta@ti.com>,  <u-kumar1@ti.com>,
  <praneeth@ti.com>
Subject: Re: [RFC PATCH 01/10] spi: spi-mem: Introduce support for tuning
 controller
In-Reply-To: <cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com> (Santhosh Kumar
	K.'s message of "Sat, 20 Sep 2025 23:25:31 +0530")
References: <20250811193219.731851-1-s-k6@ti.com>
	<20250811193219.731851-2-s-k6@ti.com> <87seguemzu.fsf@bootlin.com>
	<cb04a4ec-c643-4b80-9288-8fd8944cb4f7@ti.com>
Date: Tue, 18 Nov 2025 14:49:13 +0100
Message-ID: <mafs0ikf74fja.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Sep 20 2025, Santhosh Kumar K wrote:

[...]
>> This is actually wrong. Tuning is way more generic than that :)
>> If someone wants to use a chip at a high frequency (50MHz in your case,
>> but whatever, there is a threshold above which additional care must be
>> taken), it must go through the calibration step. It does not matter in
>> which mode you are. Calibration would still be relevant in single SDR
>> mode.
>> This 50MHz bothered Mark because it is too Cadence specific. Maybe this
>> should be a controller parameter? If the spi-mem core (or even the spi
>> core, by extensino) sees that the design allows running at XMHz (due to
>> the SPI peripheral properties or simply the absence of any limitation),
>> and if the controller states that it requires an extra tuning step above
>> YMHz (and X > Y), then it launches the calibration.
>>  From a core perspective, I would like the calibration hook to be as
>> simple as possible, because what "calibration" means is highly
>> controller and chip specific.
>
> I understand the concern here.
>
> Let me point out the options for launching the tuning procedure, along
> with the issues in each approach.
>
> Option 1: Launch tuning as part of spi_mem_exec_op()
>    - After spi_mem_access_start(), introduce a spi_mem_needs_tuning()
> check (a new callback to SPI MEM controller) to check whether the
> current op requires tuning
>    - If yes, we call spi_mem_execute_tuning()
>         - on success, mark tuning complete in a flag within SPI MEM
> Controller private data
>         - on failure, we attempt a fallback by calling
> spi_mem_adjust_op_freq() and drop to a lower supported frequency
>
> Option 2: Launch tuning within spi_controller->exec_op() implementation
>    - Very similar to option 1, except that the spi_mem_execute_tuning()
> is triggered from within the controller's exec_op() implementation
> (no need for spi_mem_needs_tuning())
>
> Drawbacks in option 1 and 2:
>    - Tuning requires multiple reads of a known pattern, but the flash
> may not always be in a state to allow read commands
>    - No fallback on failures, can't make flash-specific adjustments in
> case of a tuning failure
>    - No access to write_op() to write known pattern temporarily to an
> on-die cache. Pattern needs to be always burnt into the flash
>
>    - Plus, in option 2 - we can't call spi_mem_adjust_op_freq()
>
> While the need for tuning is dictated by Controller specific
> characteristics the ops (and state of the chip) required to complete
> tuning is under the control of spi-mem users (spi-nand/spi-nor).
> So, it's impossible to achieve tuning without the help of spi-mem users.
>
> So, Option 3: Launch from SPI MEM clients
>                           (mtd/nand/spi or mtd/spi-nor, etc.,)
>    - Once the spi-mem chip is completely enumerated and best read and
> write ops are chosen call spi_mem_needs_tuning(read_op, write_op) as
> a part of .probe()
>    - If tuning is required, call
> spi_mem_execute_tuning(read_op, write_op)
>         - If only read_op is provided, it implies the tuning pattern is
> pre-flashed to the partition
>    - On tuning failure, retry by re-running spi_mem_needs_tuning() with
> the second best set of ops (max throughput - 1)
>
> With option 3, spi_mem users are limited to calling
> spi_mem_needs_tuning() and spi_mem_execute_tuning(). Rest is hidden
> within the controller drivers. If spi-mem users change read/write ops,
> the above sequence can be re-issued.
>
> The controller can store the read_op and write_op in case of a tuning
> success and periodically re-run tuning, ensuring we always have valid
> tuning parameters.
>
> One concern with option 3 is that we may not be able to make use of
> static data on certain flash as tuning patterns (like reading parameter
> page or SFDP table for tuning instead of controller specific attack
> patterns).

Why not? How else would tuning work? Do you expect controllers to first
flash the tuning pattern and then tune the reads? That is a hard no I
think, since you don't want to over-write user data and I don't think we
will ever have any area of memory we can reliably over-write without
risking that.

I think we should start with the requirement to have the pattern flashed
already and figure out how SPI NOR or SPI NAND can discover that
(perhaps via NVMEM?).

I think SFDP is quite nice for this, but IIRC for spi-candence-quadspi,
that was not a viable option due to some reasons. If you can now make it
work with SFDP, then that would be even better, since we don't have to
deal with the pain of pre-flashing.

Overall, I think option 3 is the most promising. Options 1 and 2 will
likely add so much overhead they will end up being slower than non-PHY
reads, since tuning is usually quite expensive.

>
> Please let me know your thoughts on which of these directions makes the
> most sense.
>
> Thanks,
> Santhosh.
>

-- 
Regards,
Pratyush Yadav

