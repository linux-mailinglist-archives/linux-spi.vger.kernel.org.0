Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32B071F6F85
	for <lists+linux-spi@lfdr.de>; Thu, 11 Jun 2020 23:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgFKViR (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Jun 2020 17:38:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:36725 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgFKViR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Jun 2020 17:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591911492;
        bh=AYptKPCAxUSatQNyMDSLiyS92qMVCcnna6cxQ7i23js=;
        h=X-UI-Sender-Class:From:To:Subject:Reply-to:Date;
        b=JUGboHKkRPnOUtCgaMDUK3O6Ju8cMYuI1YFBZdKdIM2XaIQ6wezJWbciOFU/HEZ5B
         wct95ysrEB7p+dDaphBhyoUSyG73nrud7nwJKk48tNpC8kuzuevB0FUCv2znMvV2pE
         hzAJkEpRu3JSc+e8Q25k0jZ/qBmEJxVhjNLbThlg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from corona.crabdance.com ([173.228.106.43]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MGhyc-1jeX692Ira-00Dr9i; Thu, 11 Jun 2020 23:38:12 +0200
Received: by corona.crabdance.com (Postfix, from userid 1000)
        id 85924899767; Thu, 11 Jun 2020 14:37:51 -0700 (PDT)
From:   Stefan Schaeckeler <schaecsn@gmx.net>
To:     linux-spi@vger.kernel.org
Subject: How to extract opcode, addr, dummy and buffer in transfer_one_message()?
Content-Type: text/plain
Reply-to: schaecsn@gmx.net
Message-Id: <20200611213751.85924899767@corona.crabdance.com>
Date:   Thu, 11 Jun 2020 14:37:51 -0700 (PDT)
X-Provags-ID: V03:K1:B54yBBh19r+GEwNgASx8vz59y+RtRGOxzEW2e1u/PGRLUCnZFJD
 J8PaRwOSe6uXPPTnZltEKw/ScJ56eu96gFig+stEYpEuCrg9PJNaDnTumnmhhT1nV3eOkcK
 URO58iLrtk35e0eNv/tYWWWjtsI/EI5SVqy0hZMlcKbJj5UsX+I0s6JABBYZ8Ur7dVynYDH
 R3N8jvoHnSepFo+7y66jg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VVoT6AHydO0=:4w7nsSSF+fPbvvT8lWUUTG
 zSQvP5igIJe4DumUZbVihrPVgF3eu/I1/dRi6w/0ST3GQE462nJZPqLienS38tEUAPGyBpnDz
 WTun6tgdGsy0iAOWRFWkVb+ww5OEW/s5Jnspu9TVXUv752N8B9qx3ZRR1h2om/VDvAhLHwapj
 broOQxQgIVyjGLz5wlULsRdkr7gr2IYONYAnmXT8kXHq+LlDLxzpiIkiyaMivXKCIq5OQGUba
 Cs0lUA+HDWOCZyFUNiR20DWIoVqo/bvsVS9ZFtXwSIOCoqgjfeDVFo19/d1SsOj9CfyOrGDwD
 an/1W0ggHf2GlGOgxWA1IdmzqLdL0al5WPYVhSZ8A/+emIRKGpAVblY98aS3HRMt2M3P41UQT
 9Y8Gc3QhSe9mx4b7vrAHYFIwSnzr7IWGigFtRYXMmQ88jvz4y2czod5UJ9V+hNf50S9g94z27
 Zya0DjvhlR330Rat+tE1bmeX+ozYncyd8ux9q8sxp16pQgTtTcgEbe4hZtPNyF6pfpEzP5EAS
 3dtEvc5tzaowt/qMfTcXQhyI58E6mZW/QNp8s5sSBbbm+frn8qYf46JNK+2R21KptLIcvFdAQ
 Du0YSzo/y/GWJ2jWzrm5JquakIXLeuHCXmaNe+oRePR5aSMsniiU3GfE2xQkbf/8+mgphnp7g
 K9a0U3Va2j7IbS9rWPiiU/DaRoPVcVxvKGjRkF3c/5OMmCznjDAQjPVILFjpopW7qwpMXHbfH
 MTfIYqWyfQaDI3zHBz2Y1o5zyUsAhmzhUW0Ifym/3TfqsxUKMo2Sblktwl4YWe4UHMFsICYZx
 a1kIjDLsfP0PQSKcEL8OGxmK2lWe3Ndx7Nc7VHOoOGsteHZYOFUOsiKal5YoPQ2c3FM1C91Ls
 07yAkTNKthduw3U/8dmC/99WGH/rplmBC7iM17g0raeIz1d+0NonTvRTj7ZHGyKpmoSMhj4VV
 IMA9W4o+h9vc4ujOVXCCvllNIA9Lke+wz33ZJrQ/YTSBZq7xdA2WupWvruRbEx+2fEEEct0q6
 +SGdoH9QNwCesVo7E6SQSGd/6ZlqIQaYtSFncTdfys3Aq5xoDTaA9QtHtYzm4vBHquIr42sVO
 S13njB7c94+8E1vsqSegYFfUKglm6btHtvDtNmW2UGQ0XbDG9TQIuec4k+HfKweD59OG/s3yP
 3w18o9EMmBNsOsrJNnUfJ/syCKhuLpNbxgDPoEWp3kFXIGhGhitIFKXvw40m6BS9kUPTkP02Y
 1f1OdpYuf12MN8H++
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello linux-spi,

I can implement mem_ops() a/o transfer_one_message().

spi-mem.c:spi_mem_exec_op() will directly pass op to mem_ops->exec_op(). T=
here
I can easily extract opcode, addr, dummy and data buffer. It would probabl=
y
look roughly like

exec_op(struct spi_mem *mem, const struct spi_mem_op *op){
        dummy =3D addr =3D -1;

        opcode =3D op->cmd.opcode;

        addrlen=3Dop->addr.nbytes;
        if (addrlen)
            addr =3D op->addr.val;

        if (op->dummy.nbytes)
            dummy =3D QSPI_DUMMY_CYCLE;

        len=3Dop->data.nbytes;
        if (len)
            if (op->data.dir =3D=3D SPI_MEM_DATA_IN) {
                rxbuf =3D op->data.buf.in;
                is_wr =3D false;
            } else {
                txbuf =3D op->data.buf.out;
                is_wr =3D true;
            }
}

That's great. What about transfer_one_message()?

spi-mem.c:spi_mem_exec_op() builds a message consisting of multiple transf=
ers.
If there is no address, dummy or data buffer, then they will not be includ=
ed in
the transfer array as transfers are created like this

        /* op is the first transfer */
        tmpbuf[0] =3D op->cmd.opcode;
        xfers[xferpos].tx_buf =3D tmpbuf;
        ...

        if (op->addr.nbytes) {
        /* add addr transfer */
        ...
        }

        if (op->dummy.nbytes) {
        /* add dummy transfer */
        ...
        }

        if (op->data.nbytes) {
        /* add data transfer */
        ...
        }

These transfers are then passed as a message consisting of 1 to 4 transfer=
s to
transfer_one_message().

In transfer_one_message(), the first transfer is the opcode. How do I now =
what
the next transfers represent? Like in the exec_op() example above, I would=
 like
to create and initialize my variables opcode, addr, dummy and read or writ=
e
buffer.


Related question: what are the disadvantages of always using mem_ops() and
never transfer_one_message()?

Thanks,
 Stefan
