Return-Path: <linux-spi+bounces-7318-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 113CDA71870
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 15:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020A6188AE47
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 14:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9E81F3FE8;
	Wed, 26 Mar 2025 14:24:25 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220981F130F;
	Wed, 26 Mar 2025 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999065; cv=none; b=cVlJ9+IbsUZkQKbr9syQTyo+GABuK8KCnYyZHmfW3vLbpqx64YfW+F1+Z1HKAmAXQMmaZ0L9sqTbysTzD34r5aH9qmeAWj3YApO0X/zpQmMu2JmMs6olBIe9hg9hNZCF+bKsv3E6r0aFsuvAIQdH/n7fWJBnvtivGyZX6FzVmwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999065; c=relaxed/simple;
	bh=D0XE0U9hTYqwj+ZqvSvbVixtiOEZJy8Two0uLDbB068=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jp5SL8whgkC9BKGH+nyxYvrf8TM+AHgXF4n2KOLdYcvYgj3ExexA1slDz41uJ3mAJyAWeHzBq1AHLNPk5BtOGdYBOi1vuzdFSF+RKjBfjiOo2oVKslFtk/xMgILjLFyzMRs1ulX5YUpKJnLYMkdQLN3yQyaSQm5HDdbmBJAQ5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so1056161166b.3;
        Wed, 26 Mar 2025 07:24:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742999060; x=1743603860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVeEr5fe+QcsB1CPbzMqouy4dYpCMr7o6TNfEQFa78s=;
        b=EJdpioYAp4sxUg6Gy9QBX5ND3ig0AnUkk6HqmR2WTSUJ7eVFofPi9lqa74bh17CITv
         w3U5Jsx+aYu7Z0a6eNb9yO16BwpHm/VVtnG+6xPYHaQeMjM//MJJrJeUDYcCvyvrhz4b
         M1fCwm5wk8glKzqq6NMVejC9d/QHyFNqT12eeFRNt0gRaNIirYZjeiVEc7ps9JME3C0D
         uL0GRDzujceQHXpfXtqppiulAgrwMfGrkdfK51eaTrvwN/FHQqCGdi48qOwYySdyYOZE
         idvyh7gu68pVQ53TI/SRBtca5iZDnnOL6BPJA1dFknLN0+mV+tywLI3+3VLVagDV3E5X
         THhA==
X-Forwarded-Encrypted: i=1; AJvYcCUuCX0DvCyiB9hSCLhAXJrGQxFjpNU4qnqNQ5FixTVdftmDu7OAxapC2hctdNPCmBy7YyDs4fDNGCJDEJEpsg==@vger.kernel.org, AJvYcCVFha8rcuGlmcFC0bDrZKWQolT9jE479AZsCgNUbPfuHx9FoK+6Lhv8+wl2zjEOnc8Xk8uQVQcD+NdzVS07@vger.kernel.org, AJvYcCXQfcXiVP/nFoPPX+zyc6IZZVrUoPPaLWjYntelzztOe7vUOcypJ99IJtJ67zRSpt9928HLMvOg3G8w@vger.kernel.org, AJvYcCXblz8j8yd1VFkgJkhHJX4pAyF/1zBFvhkSyAc1pKoC4BCG3lG0AM9Ngj1+u9G1f82q6Y9otchxbgEy@vger.kernel.org
X-Gm-Message-State: AOJu0YxzqSmOS4hq587N0bw2tdQ0ESzdQ3oLCWnaznLd3hqT7eDXBOEV
	ggFg7LQ9j7dmPqZAZ5UhHhS9eeDzFi27Av9gjuAuceaMylA+qDX/ejf1XvTA4S0=
X-Gm-Gg: ASbGncvzeVC3BhZaeWxwPAWw6vzje3WI6kaFc0O2R8QrTbqi8nysgCEmn3bBjFSzkWD
	RkMoJwbgHjX3YCt3m0EJGIV+ppI357GqbzI8s21XTAcic+OeYhST8vdEZpbN0izE4mGmfQ5w4v5
	WJWHgSdrHZTbnEX13uLH3SNKY7uL/25mdgUCvpEVQkmnXXxtMhTD0p9dQFdfRDds3K97tUMvM99
	wKf2ElZS3cMY7kttJ0IaYOy9Cm9MDwN7v7WNaRPkECN7gffC52z+qN7qcHsHf+S51SFcra45h1y
	eWrDGtAg2uUuCYfzdOoCu4ER+p+6PcaM5uafkNvZEdNSijgaKuWgRqPlvg7gffQ8KZwfyMOCOqM
	p6hgnix4=
X-Google-Smtp-Source: AGHT+IHevpX0MztgdxgQP65bcyqlFoyoncWQIdo3b8lo6c/zWSh1PXSiDKD4RSc1XPxWaoRvZZaTzg==
X-Received: by 2002:a17:907:6095:b0:ac3:4138:6ae5 with SMTP id a640c23a62f3a-ac3f24c852dmr2117901666b.46.1742999059504;
        Wed, 26 Mar 2025 07:24:19 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef8675a9sm1040126366b.28.2025.03.26.07.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 07:24:17 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e6194e9d2cso12502952a12.2;
        Wed, 26 Mar 2025 07:24:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBuYlf29oV0/BivZZ+e9rW6qeMCtDiIAKxBcN2J8mfaLf4+zo3A2G0D3Mxk4cDjzhpTYSXqWw//t+ukCPC@vger.kernel.org, AJvYcCV9QsnLqq5CQkCrHhtCqQ1vQ58643Xi9XuKbLM4uAQqBwCpvxq9jrWzAC6yu8SJ6UDdwtMcdYd7W6pe@vger.kernel.org, AJvYcCVN6QUb+dYaIWZ5FxxtG9OZhG666CGxLEvgin/ukmPeQWtumwwl4P4FM5EAlgky7frkQHUfSMlMw/UVFsNGoA==@vger.kernel.org, AJvYcCWDZT7rO2qk6WyhsBtjHlaYa9Ppww5N6qoTdXji6KuEyLrBszqkfn+h+yCAssiePSqM6MwhVOQBIGQP@vger.kernel.org
X-Received: by 2002:a05:6402:210d:b0:5ed:2762:727a with SMTP id
 4fb4d7f45d1cf-5ed27627ba1mr4923443a12.11.1742999057224; Wed, 26 Mar 2025
 07:24:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224111414.2809669-1-quic_mdalam@quicinc.com> <20250224111414.2809669-3-quic_mdalam@quicinc.com>
In-Reply-To: <20250224111414.2809669-3-quic_mdalam@quicinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 26 Mar 2025 15:24:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUOt8PxbRt-vGfeD5=uEtMVV0TLPUridu=nCkzX9iP24Q@mail.gmail.com>
X-Gm-Features: AQ5f1JrfbKrmBiixGhwve_DBCFWEH-PHEu3H-5oG_9hBLQTIaQ4FX125IicniZo
Message-ID: <CAMuHMdUOt8PxbRt-vGfeD5=uEtMVV0TLPUridu=nCkzX9iP24Q@mail.gmail.com>
Subject: Re: [PATCH v15 2/2] spi: spi-qpic: add driver for QCOM SPI NAND flash Interface
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, miquel.raynal@bootlin.com, richard@nod.at, 
	vigneshr@ti.com, linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, 24 Feb 2025 at 12:15, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
> This driver implements support for the SPI-NAND mode of QCOM NAND Flash
> Interface as a SPI-MEM controller with pipelined ECC capability.
>
> Co-developed-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Thanks for your patch, which is now commit 7304d1909080ef0c
("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
upstream.

> Change in [v11]
>
> * Changed "depends on MTD" to "select MTD" in
>   drivers/spi/Kconfig file

Why? This is the only driver that selects MTD instead of depending on it.

> Change in [v7]
>
> * Made CONFIG_SPI_QPIC_SNAND as bool

Why? The driver uses MODULE_*, so a janitor may remove the latter.

> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -936,6 +936,15 @@ config SPI_QCOM_QSPI
>         help
>           QSPI(Quad SPI) driver for Qualcomm QSPI controller.
>
> +config SPI_QPIC_SNAND
> +       bool "QPIC SNAND controller"
> +       depends on ARCH_QCOM || COMPILE_TEST
> +       select MTD

As SPI_QPIC_SNAND is bool, this forces MTD (and various related symbols)
to be built-in, as seen in an allmodconfig kernel.

So I think SPI_QPIC_SNAND should be tristate, and it should depend on
MTD to avoid circular dependency issues.

> +       help
> +         QPIC_SNAND (QPIC SPI NAND) driver for Qualcomm QPIC controller.
> +         QPIC controller supports both parallel nand and serial nand.
> +         This config will enable serial nand driver for QPIC controller.
> +
>  config SPI_QUP
>         tristate "Qualcomm SPI controller with QUP interface"
>         depends on ARCH_QCOM || COMPILE_TEST

--- /dev/null
+++ b/drivers/spi/spi-qpic-snand.c

> +static const struct of_device_id qcom_snandc_of_match[] = {
> +       {
> +               .compatible = "qcom,ipq9574-snand",
> +               .data = &ipq9574_snandc_props,
> +       },
> +       {}
> +}

Missing semicolon, so that's why you are forcing the driver built-in? ;-)

> +MODULE_DEVICE_TABLE(of, qcom_snandc_of_match);
> +
> +static struct platform_driver qcom_spi_driver = {
> +       .driver = {
> +               .name           = "qcom_snand",
> +               .of_match_table = qcom_snandc_of_match,
> +       },
> +       .probe = qcom_spi_probe,
> +       .remove = qcom_spi_remove,
> +};
> +module_platform_driver(qcom_spi_driver);
> +
> +MODULE_DESCRIPTION("SPI driver for QPIC QSPI cores");
> +MODULE_AUTHOR("Md Sadre Alam <quic_mdalam@quicinc.com>");
> +MODULE_LICENSE("GPL");

I have sent a patch to fix these issues
https://lore.kernel.org/b63db431cbf35223a4400e44c296293d32c4543c.1742998909.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

