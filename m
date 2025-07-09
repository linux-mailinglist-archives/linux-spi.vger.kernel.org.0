Return-Path: <linux-spi+bounces-9078-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C01FAFE438
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 11:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D1B1C42A2D
	for <lists+linux-spi@lfdr.de>; Wed,  9 Jul 2025 09:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537AA28642C;
	Wed,  9 Jul 2025 09:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Vl2c3eHW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09B1286422;
	Wed,  9 Jul 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053825; cv=none; b=uiplnSvTBKkS3mDMxNkEHCaiBiGHlodphnh1uAJ5WQfl58OTGEwdgvusfKxIPAGVEh16ujfdYcz+Exr4sUTqwD4rTxmrJ+M/sDxBR/ClFQ77bUjaeUxYkl5+L10ggS3IINvASDpnf+4jlg+gtid0NI29mGeB7813+7Nr7M1OtaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053825; c=relaxed/simple;
	bh=d0jGkK6Mjl18HIJVp/ahQIiLxhwA9wSL4Pyd2Eg5xzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXX0d8JjD92exRtPzOzkawOK+Gru8HTMH2dwqTnRV2gOzteSRW9fJDMmmJHcOGkpCFIPHIlxc2ar4EUt88Pxslz8ezxoxEO+1hwcNZHA8puhLOUlKOgicxWifn8o3+K4T0TsH5B5wWjynMhij8QbWqjYeOu58lQyHDl6KdXuR8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Vl2c3eHW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23649faf69fso46908345ad.0;
        Wed, 09 Jul 2025 02:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1752053823; x=1752658623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+LaGhFdH15NRohN6jDSwkhz0ZXYVZii1BB9nePp2aU=;
        b=Vl2c3eHW0k2I0VeClyygdx5+H2JtjV9ez91GY0hhbO0GTEcqdbi7C4VA1KQji9ZeZ1
         Qc7mGabgFZportRSLiM1hHwX2Z8WUMZzjb0LQugvDkpY1pJzd4GZ97cVyk5FMyuad9vN
         KeGO+NeUXQjDaR6wTR0xIkUX9uEroeTff4UNzaoWi1Pfrcga7tOtEa1etIMg40V031R+
         S+HxHP5pTRgBl34JwwlhZaWj/DJ/YHOxWBCfkxqGU7DAoKFj/Y8yO6C29RaR0Y+yKAGL
         8fAkjyIjNZLz4V/eDRwC4GXsl5B1eXeeDm/q/7EAK3RQIX0Ia0ib/b/ldtlVVgFXR+Uz
         EobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752053823; x=1752658623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+LaGhFdH15NRohN6jDSwkhz0ZXYVZii1BB9nePp2aU=;
        b=tbH4Ijlc/AtlV/Aew+dO8MLHLgLp6DXVzFBeQHrSLCt+TTEUtu1muke2I1R4N6eltg
         pZ5KKq8+4UcNJux9afpOr2sBzSgctsuHxt/vwxzQYaj9blJP9VLP6od15JdXsvUsa/zy
         Q+q7ahukczdTNRXF3KCwy5iUz8uGU4ywaxSEibZHStX4HefKdRwkgVQzjr52YV0tDsAN
         w9Si8E0BSLizV02hoc2nw4YdXGZ7ElAKpTA+uMgxY/5qr6Q1+qpuXsvtE/j08thxYPAF
         cnhNMU6/a+Z/IbQ0LNolKzGuw6kugKCKoYBRmc5J8HGxqzPpbmpF48MxctMZL33N4GJM
         HSdA==
X-Forwarded-Encrypted: i=1; AJvYcCUbuBDovIRWMclHzew97MS1js2R6eOoH6FAZ7xtI+ICzk965Kf5HJBuki7CsDDj2iv74olYF78u8pE2@vger.kernel.org, AJvYcCXIclqtNI7jUwa+9twuI3OcNjhN7AD6L+rSGjPd3LCDCOAr71wXDmfg1CYwBUcNGmu9ZlcH5D7rjYuz@vger.kernel.org, AJvYcCXLc0D6PV/FPufqruONrX1xkBquWiC/UnUPZf50M+/rRLE+oi4FUfuWDM0r/o0SMk8rkljuiNLecvJw1Rhl@vger.kernel.org
X-Gm-Message-State: AOJu0YxCQz6pIAnFTNEjo4qXcCdK20MA6kL+10N/d+vxsV/edzwefrTS
	2lRdSpVqu21Qv6Ryspy3CKiC8wlhcfe2iStM5qzKtKiEUS+xehV3ol8dkgXAH4n+c1Nb5hJGG57
	SpBcIVF97o42cEWYjI3wv6yHI99SR3Mw=
X-Gm-Gg: ASbGncvT+8LFDgKKZs81uL/bTLP5glJC4tvB4FP9YlbEXJtRSEkfZLzCEKDhyVo9iKt
	Hy+mFjXYwmOY07Bld1X033MvDoHOOsjkhKv8R2kTXjZ8mrW4gHs/oXbNBT27vMejM/SMY8Ad3n7
	Isyd0UXAkSHuNRGiaNz9NLVDRCfp/7F0h0H+Nos7jic+UqeljKDzxrcFS+OdiaakkS56NI
X-Google-Smtp-Source: AGHT+IEwwywvEzlRHvTTHK1G+2vz8oNtYhpg6zze2DufMOLtj4x+/BetMBVk3t85MV8wrlNO97xNtmt2R0gZv4cwXFg=
X-Received: by 2002:a17:903:287:b0:235:f55d:99cc with SMTP id
 d9443c01a7336-23ddb198289mr32150745ad.2.1752053822733; Wed, 09 Jul 2025
 02:37:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704-spisg-v4-0-6b731dfbe610@amlogic.com> <20250704-spisg-v4-2-6b731dfbe610@amlogic.com>
 <CAFBinCB4Lw04StL-kPpzKHPyETKfi5FYFipHRBDDnPdtRVDrmA@mail.gmail.com> <646ef30f-cadb-40ab-a0ad-c493fbdb9709@amlogic.com>
In-Reply-To: <646ef30f-cadb-40ab-a0ad-c493fbdb9709@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 9 Jul 2025 11:36:51 +0200
X-Gm-Features: Ac12FXzaQ629wbNl6vgvdIQIhSzEtFJGPC3mJVuls0iq3-leb4WRKCyFDDxPMKE
Message-ID: <CAFBinCDctqZ_Q2aXOzU514nXBT45GYDHY5-V0cAmZvHkbUR0Mg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] spi: Add Amlogic SPISG driver
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 9, 2025 at 8:29=E2=80=AFAM Xianwei Zhao <xianwei.zhao@amlogic.c=
om> wrote:
>
> Hi Martin,
>     Thanks for your reply.
>
> On 2025/7/9 00:01, Martin Blumenstingl wrote:
> > [ EXTERNAL EMAIL ]
> >
> > Hi,
> >
> > On Fri, Jul 4, 2025 at 5:07=E2=80=AFAM Xianwei Zhao via B4 Relay
> > <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
> > [...]
> >> +       div->table =3D tbl;
> >> +
> >> +       /* Register value should not be outside of the table */
> >> +       regmap_update_bits(spisg->map, SPISG_REG_CFG_BUS, CFG_CLK_DIV,
> >> +                          FIELD_PREP(CFG_CLK_DIV, SPISG_CLK_DIV_MIN -=
 1));
> > Are you doing this to prevent errors for value zero?
> > If so, is CLK_DIVIDER_MAX_AT_ZERO applicable instead (it has been
> > discussed for the t7 clock controller recently: [0])?
> >
>
> No, if add add flag CLK_DIVIDER_MAX_AT_ZERO, reg value will equals
> divider, see
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/=
drivers/clk/clk-divider.c?h=3Dnext-20250708
> As follow in function _get_div.
>          "if (flags & CLK_DIVIDER_MAX_AT_ZERO)
>                  return val ? val : clk_div_mask(width) + 1;"
>
> But here reg value adding one equals divider.
I see, thanks.

> >> +       /* Register clk-divider */
> >> +       parent_names[0] =3D __clk_get_name(spisg->pclk);
> > Instead of using __clk_get_name my suggestion is to use struct
> > clk_parent_data with .fw_name set.
> > If you want to simplify the code further you can use helper macros
> > like CLK_HW_INIT_FW_NAME
>
> here I don't know parent fw_name, The system does not have a
> corresponding interface to obtain parent fw_name, only name (clk-core->na=
me)
The .fw_name is simply "pclk" in this case.
That clock is then internally looked up (by the common clock
framework) using the "clock-names" and "clocks" properties from your
device-tree.

[...]
> >> +static int aml_spisg_probe(struct platform_device *pdev)
> >> +{
> >> +       struct spi_controller *ctlr;
> >> +       struct spisg_device *spisg;
> >> +       struct device *dev =3D &pdev->dev;
> >> +       void __iomem *base;
> >> +       int ret, irq;
> >> +
> >> +       const struct regmap_config aml_regmap_config =3D {
> >> +               .reg_bits =3D 32,
> >> +               .val_bits =3D 32,
> >> +               .reg_stride =3D 4,
> >> +               .max_register =3D SPISG_MAX_REG,
> >> +       };
> > Most regmap_configs in Amlogic drivers are static const.
> > If you make it a static const then I suggest renaming the variable to
> > aml_spisg_regmap_config for consistency.
> >
>
> regmap_config as a local variable, it can save space.
Thanks, I was not aware of that.
For documentation purposes, with the original approach:
$ aarch64-linux-gnu-size -d drivers/spi/spi-amlogic-spisg.ko
  text    data     bss     dec     hex filename
  7504    1377       0    8881    22b1 drivers/spi/spi-amlogic-spisg.ko

and making the regmap_config static const:
$ aarch64-linux-gnu-size -d drivers/spi/spi-amlogic-spisg.ko
  text    data     bss     dec     hex filename
  7716    1377       0    9093    2385 drivers/spi/spi-amlogic-spisg.ko

[...]
> >> +       device_reset_optional(dev);
> > I haven't checked the reset code but I think the return value still
> > needs to be checked (drivers/mmc/host/meson-gx-mmc.c does so).
> > Even though the reset is optional there's conditions where we must act
> > for example on -EPROBE_DEFER (which must be propagated).
> >
>
> The reset might not exist for this node, see relevant yaml file.
This part I understand. Optional however doesn't mean that we can
simply ignore all errors.
Let's consider the following three scenarios:
1) reset not provided in .dtb -> we don't expect any error here
2) reset is provided in .dtb but the reset-controller has not been
registered -> spisg driver must propagate -EPROBE_DEFER
3) reset is provided in .dtb but reset_control_reset (which is used
internally in device_reset_optional) returns an error -> spisg must
propagate this error

Your code works for the first case but it doesn't consider the other two.
That said, I'm not sure if the third case is realistic given the T7
reset controller uses MMIO access. This may change in future though
(if SPISG IP is the same but the reset controller changes).
It still leaves the second case where the spisg driver should be
probed only after the reset controller is available.


Best regards,
Martin

