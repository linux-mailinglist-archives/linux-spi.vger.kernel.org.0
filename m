Return-Path: <linux-spi+bounces-12057-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FDDCD2454
	for <lists+linux-spi@lfdr.de>; Sat, 20 Dec 2025 01:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C07F3006442
	for <lists+linux-spi@lfdr.de>; Sat, 20 Dec 2025 00:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235952153D8;
	Sat, 20 Dec 2025 00:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hoBz8lKK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683FF20F08D
	for <linux-spi@vger.kernel.org>; Sat, 20 Dec 2025 00:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766191135; cv=none; b=DU6O4ukoV1SQ9kEhAgz0FXAFScnwpUWP9B1V+SScIvIHc822RXTG4/DmcDLk5d6ze0DniTXQZfZWH0yRUmnXPTwR4KU+HemIdsXp957s3x7quRdz9v0tA3y9RUeA3qhMrW30H1xdLB7qnjjIAco1pNq7RhhL0kkpH6xOlJCNSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766191135; c=relaxed/simple;
	bh=QLbqlMTDe2hcIMkMmOszYccf5FhZ6ttUDO+WcD+/yIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlifQPliQF9Tqz3WBibhT4O96baHs+fK93SQrTzS/eLDSt/FfJcTWmz4OGTe6c6L4JeL++eNK4Frf8/S5gkEZ6+NAmmSaxZq2iep9Rrb4g7r/NBicooDEEtHMwARi7TB9/ZbJ3yVzlMai4802KtzVDydQV9XQtQKATIUbsHIYJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hoBz8lKK; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso2650873b3a.0
        for <linux-spi@vger.kernel.org>; Fri, 19 Dec 2025 16:38:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766191133; x=1766795933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vX3i1IvghxIxcA9B7lFKYUdLaICezc99ma0xjvMjlkk=;
        b=DoeYrhmJtMO+PLuUaZxkVqLiQSVjCgWYGlqPzHtCkM5nuKFpGitve4V7C6j+cxvWue
         K+nMU7+hnh1EljuHOzfpw1alxwlotjWz2ZNa7U2UuqJ5ZZ6eo9nwHIgXlRN3wZSWBTfY
         SA+w+A230cNPavl+v/E5vUHQpqMvIa/nDJugqluZUm+t7wEXA895cnks4ggwElxLlo+L
         frZ8qljwn6PDNJ7DVUvyOXGxW4vM7YI9QWIwHFBfr3w3n+Xm6bRL8i1NCHHgrxIRIJEP
         Lnba0fwb6k9UteOVOB+oMDI9Sudj+5RQ9jInR1av71hchRrx/Mbkp7EW5WHe2wHoLSRn
         uc2w==
X-Forwarded-Encrypted: i=1; AJvYcCXAkAFom89Zw7KAtTkpa6iyt3V4cwPhhTguY/2qy7Lcc7X/SMb8Kfe6kGB4nyLQa2UUdpU2hJsnIvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWVvC61cubyKxVbbdwthZONtXiIW+jFazmNeGr5y89mR2ZiFJ7
	2t1/z5PiZnI3gwez0XqJ2XDvU8CJ0MLVWQYVngE2R5zuI52bpmRJ1MEhNzz4+P8ph/PGVoux6hX
	uAOkAoShP/L9lCABIbAcmDbJFmJKBkqC49VaGN+9e9Me08KCl3hjQnrB49K2GJO7SFl2bALUpNB
	Y2VOv6DfxIFNTNjehCrHPaWxQEdjj0Zyhod9hMDmTr8ZmN0zFLCnAJNwdkbEBUKZ3zSzJG6b03x
	FOopfxDFXQfZqSFNEo=
X-Gm-Gg: AY/fxX7BqdKnpZcYp0puS6PdvH/S5izS8EWOi98EeIGJ9WsphVlmZoU1E/zCBuDbhTH
	mP4/BxlEid6NSmeyEFh4bPT2YAwLdZWHFMi7Q7RNQqaqSqJV2Gs/Lrb65T8NMTXxaOpKb0Sjv6a
	v7qjwkLbFhtjOg6Eep7v7xmgBViXwZe0ZmfDgtmTngsbR2x7lb7Yl8tks+zpj51apkDMu1J5EDc
	rJ1ZiAe5X66t6YPpEg4bk47JP2dehOpgMuJRnsFUBA6xnHzYwZfwm6A9Ny5sESsiN8jQEDsjm+D
	iMxVaDmOnOwFiI4XXVgFOnBq0mBRL97sChB5DmYVAtnsXkVF5XXO8a5pDyWLImH8R3hzQGXKWa/
	PzIJaZhN4vhLuEiJXVZ2D7AiCrp0i3bkqlNvBpCim6JCKzcqs4A7sJS3D16FHGkFHh54RVlpPG9
	Vs17i2x9Lpxks40j6eK8+pc3i3n2rho8FUhiAx+vfqY4ymyw==
X-Google-Smtp-Source: AGHT+IGh55YtevoKPfE8941MvzVuve0QV6jt7zQhoBzSlES66o0uo/wDpz1J1v9LU1+1aqFmL+GQSysgoveE
X-Received: by 2002:a05:6a20:7d9f:b0:35d:3f07:ba34 with SMTP id adf61e73a8af0-376a8ebe18amr4527795637.31.1766191132535;
        Fri, 19 Dec 2025 16:38:52 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-c1e79617ef3sm254071a12.3.2025.12.19.16.38.52
        for <linux-spi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Dec 2025 16:38:52 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-6446bb04e1eso3488436d50.2
        for <linux-spi@vger.kernel.org>; Fri, 19 Dec 2025 16:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1766191131; x=1766795931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vX3i1IvghxIxcA9B7lFKYUdLaICezc99ma0xjvMjlkk=;
        b=hoBz8lKK+qJkhGUVXG4TYe7euEQK9bGEhO76AnokXUTb6ME21WF4OQGGx/T/yEvYvn
         CHNBYzu/Feku5HgTEcPgSK+2FvzKCkjhnxL+i3MtDJhCfiKIsPGupwhkRJizrIxXZOnB
         A6c3J3P+XR2zQQGbugFDBlmZ3fNJKFpdYqKBw=
X-Forwarded-Encrypted: i=1; AJvYcCXQadOtV1mQh7Rd/Ifzxw8f9sm8jJHtD0WolNSRl1B6nTkBfSSMnf6w5ug6oQTHFY95GhGH2Drz/po=@vger.kernel.org
X-Received: by 2002:a05:690e:1486:b0:63f:ba88:e8ee with SMTP id 956f58d0204a3-6466a85a863mr4049696d50.21.1766191131153;
        Fri, 19 Dec 2025 16:38:51 -0800 (PST)
X-Received: by 2002:a05:690e:1486:b0:63f:ba88:e8ee with SMTP id
 956f58d0204a3-6466a85a863mr4049671d50.21.1766191130824; Fri, 19 Dec 2025
 16:38:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217211026.173946-1-jonas.gorski@gmail.com>
In-Reply-To: <20251217211026.173946-1-jonas.gorski@gmail.com>
From: William Zhang <william.zhang@broadcom.com>
Date: Fri, 19 Dec 2025 16:38:39 -0800
X-Gm-Features: AQt7F2rcxsH8Y_fSUopGeNc91WfvVctppF3gTWAVLj1PPiQjt3mZ2lL9UjwA0GQ
Message-ID: <CAHi4H7FrnW0956t2BYrNNVFOEkJ4t2vfStMRCqKfkDkwD0vybA@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm63xx-hsspi: add support for 1-2-2 read ops
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Kursad Oney <kursad.oney@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Mark Brown <broonie@kernel.org>, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000001b6530646576b18"

--00000000000001b6530646576b18
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

We are doing some testing on the SPI NAND chips and will update once
we have the result.

Thanks,
William
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

--00000000000001b6530646576b18
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
4qqKYnqWf/LZRARAdvqH/NYOrjUQgJGhkC0UY8ja0hMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjUxMjIwMDAzODUxWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEArguhblpt3RYfcj01374Jw3ah4s4P7wVQSgqA
lEAMjUQS/fNJTRXsqQYOkHgNhYB4EPF661FYHbdVRCLYCRahI/cbDGvZHKnz0XSmBcL1rM/XN+wJ
+f/Fxv0FStbk8PhqMYJfcqNGkTToMYJK3zHUSXhERg3vvtgbGMD4SgtGiwnljcUQzg5nXrR2H2YS
+E4z8HhJxMLYDJh/bZTX4hQGuCy1SDKAjqud7o0qwenUNrYzCtoqAQCXISdsuqVFCQhWbcqhSJPB
lGgO1OprYtaGWVq+xXNXB3oYZQm5SjA9ll/tCXGVRgX1xj8hUYaOexvWM14DwUEhke7H7/k1e30i
JA==
--00000000000001b6530646576b18--

