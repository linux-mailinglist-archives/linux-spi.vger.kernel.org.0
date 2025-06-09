Return-Path: <linux-spi+bounces-8392-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE233AD1F25
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 15:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018843AF3BC
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 13:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60E125D1EE;
	Mon,  9 Jun 2025 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUFx4Ao9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAB425A65A;
	Mon,  9 Jun 2025 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476448; cv=none; b=AwNm2jpGCmiJw3GlLJYAYrdPh6QMMTL/b9pj63ovNz66KaO7zJoUOI27kCCrQXssujr6itsPy0VQ9KNTgGDXVS/Pmat0t8UadZ2XObsM3fFLGlFH5o5LKVQgp1+GDU88F9Q+U7B7KlDAItmuQj4PDLCKuU6xwp3Qcd2WaP0Y0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476448; c=relaxed/simple;
	bh=PWNpIUfACgNMqjyCpMvNLYXJP3ujq/QCOWwkCMkHvLk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VRhS0vLuxjhjWioxHccum+1Q1I8X+WFK75cyc5ZjV1ISQlO6kQoyBBlSMuC7e1hlT/vshDhsw6PJyoj6yCesw0jyiFR4ooFSv5rwF+DSGNhRfRUVz2xsWZQQnOvwGHojM6OeSE2Fv+AbdaD9GqlIhiRGSuxAoAWKnY++vWuSgsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUFx4Ao9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9F3C4CEEB;
	Mon,  9 Jun 2025 13:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749476448;
	bh=PWNpIUfACgNMqjyCpMvNLYXJP3ujq/QCOWwkCMkHvLk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lUFx4Ao9NaOycYVdbGZ5Xy1c+6vjqNNzhdDlEg1Il1qHQFlEDgX8pe+2yoOR2Y4od
	 gVo6zDq7jHZm0HA7RkmYHAQ2bXAfRYAsaNqax36uhk923N580AubfL+h5sOhUUAKJw
	 YcJmK93tYas3qBgq4l0j6sK1sG7kVg22nIMvMnZwaUXMInoc1E0XucmLt2m82Lg+68
	 SNQaaa5moGyE8OqRbGlUcBaHv9JpiNDegJB2R6wW1CtVzTUHn3/sFMoQLIQWpCpAgt
	 EB0Iko69IC+vPMHRMkTCaf7qzR+uCKD3FgFt1+7GSYkOb5cSCJ81aiE8u6A4JFSf2J
	 eP9XHH0D0sHlA==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250529-qpic-snand-remove-qpic_snand_op-v1-1-6e42b772d748@gmail.com>
References: <20250529-qpic-snand-remove-qpic_snand_op-v1-1-6e42b772d748@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: remove 'qpic_snand_op' structure
Message-Id: <174947644664.127013.16116071467167037102.b4-ty@kernel.org>
Date: Mon, 09 Jun 2025 14:40:46 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 29 May 2025 19:35:44 +0200, Gabor Juhos wrote:
> The 'qpic_snand_op' structure is used only in the qcom_spi_send_cmdaddr()
> function as a type of a local variable. Additionally, the sole purpose of
> that variable is to keep some interim values before those gets passed as
> arguments for cpu_to_le32() calls.
> 
> In order to simplify the code, remove the definition of the structure
> along with the local variable, and use the corresponding values directly
> as parameters for cpu_to_le32() calls.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-qpic-snand: remove 'qpic_snand_op' structure
      commit: f73dc37ebf45573349aee0aae168e8dc3d13ecee

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


