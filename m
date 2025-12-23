Return-Path: <linux-spi+bounces-12078-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1FDCD7DE3
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 03:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EDA76301C667
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 02:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2899B214A64;
	Tue, 23 Dec 2025 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RS4z+cnT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7630C2E65D
	for <linux-spi@vger.kernel.org>; Tue, 23 Dec 2025 02:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766457047; cv=none; b=fyHkKYDVKUNY4S1pGlDUOcoa+mV8IG+mKaq/w4piQG3y07G912i77gKtttYB8mCNa/1e0xIKbQV9sUrYVIOGUTunK6MLJWxaLSTaUNeSwZ+N5Bb1ksiBarCcGh9VXi97YBy8mlf7RGd+W1Ng9lX0mpSciN+kUI1zdaYXvBZ58PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766457047; c=relaxed/simple;
	bh=Y8ZXDNT9NrY0zqsdx2aImEMt23rywL02KtSargNQtjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZ9kRDud2CCj3+rcmAmZvn8QIHvsD7+8+nMlUsrHEbYuE2EPJyfcQEnTo0MG5+V0yJEvLCDkrOo09bwQtClpdq5zHMRoyS7Mi4ux7r5yCYsCvoDDOsXEoHKgrUVXafjYPJEqvAR4p2b0zQXRpYw9TQKIZnW4zlUjGkbLdZAqxG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RS4z+cnT; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso4361841a12.3
        for <linux-spi@vger.kernel.org>; Mon, 22 Dec 2025 18:30:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766457045; x=1767061845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YGptDmgcM2LaLaMLOu8r0DnfdvMzVaGCuJIQrr0LK0s=;
        b=GYiLhtBYpnldC15MVFhWeng04/DOV66xk+QZ26P0dFZDFDwtu5o9Uhh8LECB76MEjI
         cYmJ8uC5UCyAzWooBlz8geo4vgbzTwXyc/e4yntFzH3iV65lfWN/jGCDAundLKm2INnW
         8WS5TxPtGmwKv0x3urT9xhN76RFWUahPtlydrLnfFLlfxmEQdV3iwS2Bwic3wirqoDCv
         BuP27xyf/EJ0zXgj9485gNSqfBbA/m6VlTzCErQzJjogiXA602ejaABd7yzHG2m0KH/F
         RtLbPyEIt5tIIRWY5kMWJFK7xqmOJV43MxsgRylWGzP9PrLYZCf2cmxy5M65P03rgjkk
         EsdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6zb4aCJN9XfoeMKukd+FJcC7dSsTKae0+3ysES3UT1dw9JoaJtyF38Xqo+nHRNZcHJI8lS+zEM+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjeuIEzx8PuV4oDQd9NO7C/jb64yE5QctgeRzEI8FzDQ71RIVB
	G2FceBCYXiMBHQE1H9F/CK8Y2Nvex+qURt2rBA4kmUkZSitxEiQwUJpRLPbQYcREIabCCu3mTqo
	2gzwwJa0a4laDd2lVcSDlSOR9sH4GJIEhGHLaIrGxoTx21LDNqfluH38b4VobIGuJse9jg77DG7
	BrLwwGtHDZXjeedPi1tUiFh+kiG/WOpgIdpFsIKwdFwGKFClEJKsryMw+g4UICvOMuPICf4SB1n
	ZtNSwxaK9lCPpyP
X-Gm-Gg: AY/fxX6JPovaOdKT9saDCAWgq37H9bV+xlIpLsNxVkM25GdY5dsBHXBp2i1gSvAUCIG
	+W5oLfQa9uGUaxCp0JokN9QT07sxJOWi6Zt1TglJPB1YHCqcF+pxpfKNyiu5cybhHQL80x3AhPu
	NQLEo+Pymz/XywJ5u/0eT68LrOjIycHND/TC5d0+Vm8dEOIu2VerB6HTRgZQWcLCT+YJihb11iE
	htwecXg4EW+zk27JYfo71hlQ2n8sgugEhANGxV1ja8XfOpG9CzPbwqdwbHkeoYA2gEo5qaiIZW5
	hRTt/pj9UdlxvzR+HFx+uMPOyA6Fm1u3Xu+SFwabNsjDJqTb17CxZqWc374WtZkEoJU5j+iONfs
	yt2QTHuzG/GEABGA/mcH+6jtxNCkS14T8fdqp+Tw3C6wD/iOq3FIxo3mfzGFZXKl6NirSr3uxFT
	WCRkjqZ4O2mlVSeJspJkH7BzYg4DM9FnPzS9uTYVcDghO3lg==
X-Google-Smtp-Source: AGHT+IH+hxF6ZRn/wPhZggR1syjhjsCTbqupQOVzXQTQrblKrEqbo1GHwwmzV21ILp955p3vW0JtQrqkk7bj
X-Received: by 2002:a05:7022:987:b0:11b:ca88:c4f7 with SMTP id a92af1059eb24-12172309d60mr14058371c88.40.1766457044450;
        Mon, 22 Dec 2025 18:30:44 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-10.dlp.protect.broadcom.com. [144.49.247.10])
        by smtp-relay.gmail.com with ESMTPS id a92af1059eb24-12172439a90sm2450656c88.0.2025.12.22.18.30.44
        for <linux-spi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Dec 2025 18:30:44 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-78a8110330aso58747767b3.0
        for <linux-spi@vger.kernel.org>; Mon, 22 Dec 2025 18:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766457043; x=1767061843; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YGptDmgcM2LaLaMLOu8r0DnfdvMzVaGCuJIQrr0LK0s=;
        b=RS4z+cnTAByAiUeXQRMtyGmgx1n/Yi+EWHR1q5WtBZhSTnzCzml6zKu2JzEe9CBxZU
         Sk/6BEQx/m+ieEOXj5+Xuielph4HOJE/4pyxkX0H6awMP36WsPuFBI7LZjF7m0EjNMD0
         vTq0ziEQuAOcLT9xfsNy4qyW40OyINY9Sg0/8=
X-Forwarded-Encrypted: i=1; AJvYcCWllLZKQ0Lz1UPW1x0FhqkbMe44i4aL27Ar2pgn7QDaqS3rUsa7XPeftC4RmJpR9GO6JptfsQno39g=@vger.kernel.org
X-Received: by 2002:a05:690e:50c:b0:63f:96d7:a350 with SMTP id 956f58d0204a3-6466a8dbe03mr7585499d50.66.1766457043063;
        Mon, 22 Dec 2025 18:30:43 -0800 (PST)
X-Received: by 2002:a05:690e:50c:b0:63f:96d7:a350 with SMTP id
 956f58d0204a3-6466a8dbe03mr7585489d50.66.1766457042615; Mon, 22 Dec 2025
 18:30:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217211026.173946-1-jonas.gorski@gmail.com>
In-Reply-To: <20251217211026.173946-1-jonas.gorski@gmail.com>
From: William Zhang <william.zhang@broadcom.com>
Date: Mon, 22 Dec 2025 18:30:32 -0800
X-Gm-Features: AQt7F2quABsiFq6vRstoZJqOGMvItdW74OV5edbi_HYMrpve__RmnouNyWBoPwY
Message-ID: <CAHi4H7GOXjtVR-y9=dEiwizX14VcEp808fpKdB+x0J3HmYM8Ag@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm63xx-hsspi: add support for 1-2-2 read ops
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Kursad Oney <kursad.oney@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Mark Brown <broonie@kernel.org>, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Regan <dregan@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000097c72c0646955424"

--00000000000097c72c0646955424
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Wed, Dec 17, 2025 at 1:10=E2=80=AFPM Jonas Gorski <jonas.gorski@gmail.co=
m> wrote:
>
> Add support for 1-2-2 read ops by separately calculating the switch from
> single-bit to multi-bit, and then switching within the prepend data.
>
> This allows us to support single-bit write followed by multi-bit write
> followed by multi-bit read, and we do not need to reject 1-2-2 read
> operations anymore.
>
> Tested on BCM963268BU_P300 with custom fixup to allow 1-2-2 on the
> non-SDFP capable s25fl129p1 attached (which it actually supports):
>
> root@OpenWrt:~# cat /sys/kernel/debug/spi-nor/spi1.0/params
> name            s25fl129p1
> id              01 20 18 4d 01 01
> size            16.0 MiB
> write size      1
> page size       256
> address nbytes  3
> flags           HAS_16BIT_SR | NO_READ_CR
>
> opcodes
>  read           0xbb
>   dummy cycles  4
>  erase          0xd8
>  program        0x02
>  8D extension   none
>
> protocols
>  read           1S-2S-2S
>  write          1S-1S-1S
>  register       1S-1S-1S
>
> Reading from flash is still working as expected:
>
> [    1.070000] parser_imagetag: rootfs: CFE image tag found at 0x0 with v=
ersion 6, board type 963168VX
> [    1.080000] parser_imagetag: Partition 0 is rootfs offset 100 and leng=
th 665000
> [    1.090000] parser_imagetag: Partition 1 is kernel offset 665100 and l=
ength 136fa1
> [    1.100000] parser_imagetag: Spare partition is offset 7b0000 and leng=
th 30000
>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>  drivers/spi/spi-bcm63xx-hsspi.c | 64 +++++++++++++++++++++------------
>  1 file changed, 41 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hs=
spi.c
> index 18261cbd413b..d9e972ef2abd 100644
> --- a/drivers/spi/spi-bcm63xx-hsspi.c
> +++ b/drivers/spi/spi-bcm63xx-hsspi.c
> @@ -142,6 +142,7 @@ struct bcm63xx_hsspi {
>         u32 wait_mode;
>         u32 xfer_mode;
>         u32 prepend_cnt;
> +       u32 md_start;
>         u8 *prepend_buf;
>  };
>
> @@ -268,18 +269,20 @@ static bool bcm63xx_prepare_prepend_transfer(struct=
 spi_controller *host,
>  {
>
>         struct bcm63xx_hsspi *bs =3D spi_controller_get_devdata(host);
> -       bool tx_only =3D false;
> +       bool tx_only =3D false, multidata =3D false;
>         struct spi_transfer *t;
>
>         /*
>          * Multiple transfers within a message may be combined into one t=
ransfer
>          * to the controller using its prepend feature. A SPI message is =
prependable
>          * only if the following are all true:
> -        *   1. One or more half duplex write transfer in single bit mode
> -        *   2. Optional full duplex read/write at the end
> -        *   3. No delay and cs_change between transfers
> +        *   1. One or more half duplex write transfers at the start
> +        *   2. Optional switch from single to dual bit within the write =
transfers
> +        *   3. Optional full duplex read/write at the end if all single =
bit
> +        *   4. No delay and cs_change between transfers
>          */
>         bs->prepend_cnt =3D 0;
> +       bs->md_start =3D 0;
>         list_for_each_entry(t, &msg->transfers, transfer_list) {
>                 if ((spi_delay_to_ns(&t->delay, t) > 0) || t->cs_change) =
{
>                         bcm63xx_prepend_printk_on_checkfail(bs,
> @@ -297,31 +300,44 @@ static bool bcm63xx_prepare_prepend_transfer(struct=
 spi_controller *host,
>                                 return false;
>                         }
>
> -                       if (t->tx_nbits > SPI_NBITS_SINGLE &&
> -                               !list_is_last(&t->transfer_list, &msg->tr=
ansfers)) {
> +                       if (t->tx_nbits =3D=3D SPI_NBITS_SINGLE &&
> +                           !list_is_last(&t->transfer_list, &msg->transf=
ers) &&
> +                           multidata) {
>                                 bcm63xx_prepend_printk_on_checkfail(bs,
> -                                        "multi-bit prepend buf not suppo=
rted!\n");
> +                                        "single-bit after multi-bit not =
supported!\n");
>                                 return false;
>                         }
>
> -                       if (t->tx_nbits =3D=3D SPI_NBITS_SINGLE) {
> -                               memcpy(bs->prepend_buf + bs->prepend_cnt,=
 t->tx_buf, t->len);
> -                               bs->prepend_cnt +=3D t->len;
> -                       }
> +                       if (t->tx_nbits > SPI_NBITS_SINGLE)
> +                               multidata =3D true;
> +
> +                       memcpy(bs->prepend_buf + bs->prepend_cnt, t->tx_b=
uf, t->len);
> +                       bs->prepend_cnt +=3D t->len;
> +
> +                       if (t->tx_nbits =3D=3D SPI_NBITS_SINGLE)
> +                               bs->md_start +=3D t->len;
> +
>                 } else {
>                         if (!list_is_last(&t->transfer_list, &msg->transf=
ers)) {
>                                 bcm63xx_prepend_printk_on_checkfail(bs,
>                                          "rx/tx_rx transfer not supported=
 when it is not last one!\n");
>                                 return false;
>                         }
> +
> +                       if (t->rx_buf && t->rx_nbits =3D=3D SPI_NBITS_SIN=
GLE &&
> +                           multidata) {
> +                               bcm63xx_prepend_printk_on_checkfail(bs,
> +                                        "single-bit after multi-bit not =
supported!\n");
> +                               return false;
> +                       }
>                 }
>
>                 if (list_is_last(&t->transfer_list, &msg->transfers)) {
>                         memcpy(t_prepend, t, sizeof(struct spi_transfer))=
;
>
> -                       if (tx_only && t->tx_nbits =3D=3D SPI_NBITS_SINGL=
E) {
> +                       if (tx_only) {
>                                 /*
> -                                * if the last one is also a single bit t=
x only transfer, merge
> +                                * if the last one is also a tx only tran=
sfer, merge
>                                  * all of them into one single tx transfe=
r
>                                  */
>                                 t_prepend->len =3D bs->prepend_cnt;
> @@ -329,7 +345,7 @@ static bool bcm63xx_prepare_prepend_transfer(struct s=
pi_controller *host,
>                                 bs->prepend_cnt =3D 0;
>                         } else {
>                                 /*
> -                                * if the last one is not a tx only trans=
fer or dual tx xfer, all
> +                                * if the last one is not a tx only trans=
fer, all
>                                  * the previous transfers are sent throug=
h prepend bytes and
>                                  * make sure it does not exceed the max p=
repend len
>                                  */
> @@ -339,6 +355,15 @@ static bool bcm63xx_prepare_prepend_transfer(struct =
spi_controller *host,
>                                         return false;
>                                 }
>                         }
> +                       /*
> +                        * If switching from single-bit to multi-bit, mak=
e sure
> +                        * the start offset does not exceed the maximum
> +                        */
> +                       if (multidata && bs->md_start > HSSPI_MAX_PREPEND=
_LEN) {
> +                               bcm63xx_prepend_printk_on_checkfail(bs,
> +                                       "exceed max multi-bit offset, abo=
rt prepending transfers!\n");
> +                               return false;
> +                       }
>                 }
>         }
>
> @@ -381,11 +406,11 @@ static int bcm63xx_hsspi_do_prepend_txrx(struct spi=
_device *spi,
>
>                 if (t->rx_nbits =3D=3D SPI_NBITS_DUAL) {
>                         reg |=3D 1 << MODE_CTRL_MULTIDATA_RD_SIZE_SHIFT;
> -                       reg |=3D bs->prepend_cnt << MODE_CTRL_MULTIDATA_R=
D_STRT_SHIFT;
> +                       reg |=3D bs->md_start << MODE_CTRL_MULTIDATA_RD_S=
TRT_SHIFT;
>                 }
>                 if (t->tx_nbits =3D=3D SPI_NBITS_DUAL) {
>                         reg |=3D 1 << MODE_CTRL_MULTIDATA_WR_SIZE_SHIFT;
> -                       reg |=3D bs->prepend_cnt << MODE_CTRL_MULTIDATA_W=
R_STRT_SHIFT;
> +                       reg |=3D bs->md_start << MODE_CTRL_MULTIDATA_WR_S=
TRT_SHIFT;
>                 }
>         }
>
> @@ -692,13 +717,6 @@ static bool bcm63xx_hsspi_mem_supports_op(struct spi=
_mem *mem,
>         if (!spi_mem_default_supports_op(mem, op))
>                 return false;
>
> -       /* Controller doesn't support spi mem dual io mode */
> -       if ((op->cmd.opcode =3D=3D SPINOR_OP_READ_1_2_2) ||
> -               (op->cmd.opcode =3D=3D SPINOR_OP_READ_1_2_2_4B) ||
> -               (op->cmd.opcode =3D=3D SPINOR_OP_READ_1_2_2_DTR) ||
> -               (op->cmd.opcode =3D=3D SPINOR_OP_READ_1_2_2_DTR_4B))
> -               return false;
> -
>         return true;
>  }
>
> --
> 2.43.0
>

Acked-by: William Zhang <william.zhang@broadcom.com>

--00000000000097c72c0646955424
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
PRi27wH/XHTDMdyL0Org+kxniXue6MSNJvcQwaLO/UQrmgTygBlVGa+Qg9ZFfS00xvuqeYH7tImO
48WiXeu9rgn5KTH0IWP1+R74KIgxJQ+65la+caZvxwC9V3ik5p/LOGA2qS4GEjGuaYF8QKhRTR4h
/QBSktqZLbzVxpjJXrqFTA2BLlYRp9hPhqNxbn46WuLufpMWhFtjUoQi/8fRRWRsMAY0o1J0f+kB
6EI8FoxPTOpvuLRonqHIWMHk5YRnDdqJ3G5Oc8zmV+UCAwEAAaOCAd4wggHaMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJQYD
VR0RBB4wHIEad2lsbGlhbS56aGFuZ0Bicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQw
HwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFHjI7pbQZurVKsSRE/a9
7gUEyVCkMA0GCSqGSIb3DQEBCwUAA4ICAQCFA4fU1GnG8sY7kyUXp5tle+VeWveoWb272jPauU5R
w+udkhVXmnR0Kg7RgkCD00PLTKHNRyegXXDMArs3N9NhO3s9eSp9KjDh+h3WuQWCJH3QBHLGW0qE
fyV87wUtBIy/QsHwO4S8OlOZiXECR7V1EGIF6t3s0W+3UzgYeHL+Ttuhda+2wIVY0EbS0eNH9Vob
4YG17VTBBe7hyobXFpd9d1JGENFzIWncPUshOE0Wv7KlkrRc6aBOpL4p5xO1pHi9h9w8utyHkMoV
nefXixkn5YVHnuV/jbSF/IM4Mlqt0E+n/TRp2c0eR+1AauZKENV2syNBo4aMa0BkmikBjLSnDjt/
TYQdwHNWdV495n71idvueWwTFUhUsnudYcnh42eZENopBOYjVu2WhsffyrNz0hsuR85LriqSuBbf
drd9DMo3DgtfJ7hh4sEAhSw/x/Br86rfLBftZMU02htlnkOI9Tp1QuDsr9+MsqY6AjKeXAy67m7H
TVAZ9uyO9N20yU0p7igESOWKR1ccL1TPA1jrSHK18Y75ot5199FNWeE/UKoDKSML39iPZho9XPh/
/RlsfRFiVOPrI5Gwi4YfIfi0jjEWf310/CYEmA5jrp5gUQSdo/+FgfXLKDFiEHCf5b3B1l70r6bR
WkDCNNacYJWZtSp87i6jmw+l5xx7OkEJ9DGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAX
BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1F
IENBIDIwMjMCDD2ooFIye/WiO3KgZTANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg
+2AN0btdOHvjRw9X8wuM/WWi97BSblc3P5+l4X+45HUwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjUxMjIzMDIzMDQzWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAV/rI1wte/dCdHNbSr1Mg4cupqO8Xj5dIbz+T
NBOC/VdazpLwMVVN6FlySwFdNrmV/Mvby0G0Cu2rSWgZRfmuNwA6JnnSZUFCIpXAD8Rxb9MbbsAH
IZSFezePn28YE8PRPrsIAf1cSnoy4O4ksq/QjH5uoOFQWv9jA8r5AKp+RiuW/eWwUxppCUcmBGOE
cYvID+c3AI9YF9i0S/TCflLZrt17lA4XwJZSKY0+K3Cs1b5f+dFdtiQvW3jy/lUWH9NCjZpjusZl
9rsEXdroWusppP5vDiLDcHB3eGm/26kIPNkuMHdvfeo5lIUrjGuE7ey8kkQPucPdakDl8ArmdGw/
Uw==
--00000000000097c72c0646955424--

