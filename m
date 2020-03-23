Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA2218F36C
	for <lists+linux-spi@lfdr.de>; Mon, 23 Mar 2020 12:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgCWLIl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Mar 2020 07:08:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44648 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgCWLIl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 23 Mar 2020 07:08:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NB4Gd5163206;
        Mon, 23 Mar 2020 11:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=bkICJOKf8zYN8svgxRFr/pPZLAmmHlHuHmWYDIJfuFw=;
 b=afs+ez5YRrOsuE7rA3bEdRPJ3YXkKph3sv03bFfZDsC1eE6vafumoZKJ8q4dyLy1T+dV
 uQO/vfrRKP81OF8RRSGLTm6GZTnQ52oFO0v92cWRfsA6RBMe9P0iBSgn9B8n6XbtB8Ps
 /Yg2dwabEWAHRND4WSE0rVq3VMoPJGFTDwApgH7rNofiuLrjp5+OjSggcpwTzyEDjOBZ
 ZLElUbg23muSstE6gnJols8K3+3fU6/pDELbDzKP3Up8rrd1FIy7roJMUP2FQVSSu1Xf
 xjZrXgK6w91OFn4cXY1JjVzuyO114/W/u6wxSD52iX2u8yreQ3LyP8vf8MIlzP51TqWw Nw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2yx8abtw66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 11:08:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NAv3hF066901;
        Mon, 23 Mar 2020 11:08:34 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2ywwuhtddu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 11:08:33 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02NB8W0a021564;
        Mon, 23 Mar 2020 11:08:32 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Mar 2020 04:08:31 -0700
Date:   Mon, 23 Mar 2020 14:08:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Douglas Anderson <dianders@chromium.org>
Cc:     kbuild-all@lists.01.org, Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v2] spi: spi-geni-qcom: Speculative fix of "nobody cared"
 about interrupt
Message-ID: <20200323110756.GD26299@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317133653.v2.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230065
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 adultscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230065
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Douglas,

url:    https://github.com/0day-ci/linux/commits/Douglas-Anderson/spi-spi-geni-qcom-Speculative-fix-of-nobody-cared-about-interrupt/20200318-043933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/spi/spi-geni-qcom.c:385 setup_fifo_xfer() warn: inconsistent returns 'irq'.
drivers/spi/spi-geni-qcom.c:385 setup_fifo_xfer() warn: inconsistent returns 'mas->lock'.

# https://github.com/0day-ci/linux/commit/365ef891fdac5e58b1f621b0b0d57608ffafeb2b
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 365ef891fdac5e58b1f621b0b0d57608ffafeb2b
vim +/irq +385 drivers/spi/spi-geni-qcom.c

561de45f72bd5f Girish Mahadevan 2018-10-03  305  static void setup_fifo_xfer(struct spi_transfer *xfer,
561de45f72bd5f Girish Mahadevan 2018-10-03  306  				struct spi_geni_master *mas,
561de45f72bd5f Girish Mahadevan 2018-10-03  307  				u16 mode, struct spi_master *spi)
561de45f72bd5f Girish Mahadevan 2018-10-03  308  {
561de45f72bd5f Girish Mahadevan 2018-10-03  309  	u32 m_cmd = 0;
561de45f72bd5f Girish Mahadevan 2018-10-03  310  	u32 spi_tx_cfg, len;
561de45f72bd5f Girish Mahadevan 2018-10-03  311  	struct geni_se *se = &mas->se;
561de45f72bd5f Girish Mahadevan 2018-10-03  312  
365ef891fdac5e Douglas Anderson 2020-03-17  313  	spin_lock_irq(&mas->lock);
365ef891fdac5e Douglas Anderson 2020-03-17  314  
561de45f72bd5f Girish Mahadevan 2018-10-03  315  	spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
561de45f72bd5f Girish Mahadevan 2018-10-03  316  	if (xfer->bits_per_word != mas->cur_bits_per_word) {
561de45f72bd5f Girish Mahadevan 2018-10-03  317  		spi_setup_word_len(mas, mode, xfer->bits_per_word);
561de45f72bd5f Girish Mahadevan 2018-10-03  318  		mas->cur_bits_per_word = xfer->bits_per_word;
561de45f72bd5f Girish Mahadevan 2018-10-03  319  	}
561de45f72bd5f Girish Mahadevan 2018-10-03  320  
561de45f72bd5f Girish Mahadevan 2018-10-03  321  	/* Speed and bits per word can be overridden per transfer */
561de45f72bd5f Girish Mahadevan 2018-10-03  322  	if (xfer->speed_hz != mas->cur_speed_hz) {
561de45f72bd5f Girish Mahadevan 2018-10-03  323  		int ret;
561de45f72bd5f Girish Mahadevan 2018-10-03  324  		u32 clk_sel, m_clk_cfg;
561de45f72bd5f Girish Mahadevan 2018-10-03  325  		unsigned int idx, div;
561de45f72bd5f Girish Mahadevan 2018-10-03  326  
561de45f72bd5f Girish Mahadevan 2018-10-03  327  		ret = get_spi_clk_cfg(xfer->speed_hz, mas, &idx, &div);
561de45f72bd5f Girish Mahadevan 2018-10-03  328  		if (ret) {
561de45f72bd5f Girish Mahadevan 2018-10-03  329  			dev_err(mas->dev, "Err setting clks:%d\n", ret);
561de45f72bd5f Girish Mahadevan 2018-10-03  330  			return;

Needs to drop the lock before returning.

561de45f72bd5f Girish Mahadevan 2018-10-03  331  		}
561de45f72bd5f Girish Mahadevan 2018-10-03  332  		/*
561de45f72bd5f Girish Mahadevan 2018-10-03  333  		 * SPI core clock gets configured with the requested frequency
561de45f72bd5f Girish Mahadevan 2018-10-03  334  		 * or the frequency closer to the requested frequency.
561de45f72bd5f Girish Mahadevan 2018-10-03  335  		 * For that reason requested frequency is stored in the
561de45f72bd5f Girish Mahadevan 2018-10-03  336  		 * cur_speed_hz and referred in the consecutive transfer instead
561de45f72bd5f Girish Mahadevan 2018-10-03  337  		 * of calling clk_get_rate() API.
561de45f72bd5f Girish Mahadevan 2018-10-03  338  		 */
561de45f72bd5f Girish Mahadevan 2018-10-03  339  		mas->cur_speed_hz = xfer->speed_hz;
561de45f72bd5f Girish Mahadevan 2018-10-03  340  		clk_sel = idx & CLK_SEL_MSK;
561de45f72bd5f Girish Mahadevan 2018-10-03  341  		m_clk_cfg = (div << CLK_DIV_SHFT) | SER_CLK_EN;
561de45f72bd5f Girish Mahadevan 2018-10-03  342  		writel(clk_sel, se->base + SE_GENI_CLK_SEL);
561de45f72bd5f Girish Mahadevan 2018-10-03  343  		writel(m_clk_cfg, se->base + GENI_SER_M_CLK_CFG);
561de45f72bd5f Girish Mahadevan 2018-10-03  344  	}
561de45f72bd5f Girish Mahadevan 2018-10-03  345  
561de45f72bd5f Girish Mahadevan 2018-10-03  346  	mas->tx_rem_bytes = 0;
561de45f72bd5f Girish Mahadevan 2018-10-03  347  	mas->rx_rem_bytes = 0;
561de45f72bd5f Girish Mahadevan 2018-10-03  348  	if (xfer->tx_buf && xfer->rx_buf)
561de45f72bd5f Girish Mahadevan 2018-10-03  349  		m_cmd = SPI_FULL_DUPLEX;
561de45f72bd5f Girish Mahadevan 2018-10-03  350  	else if (xfer->tx_buf)
561de45f72bd5f Girish Mahadevan 2018-10-03  351  		m_cmd = SPI_TX_ONLY;
561de45f72bd5f Girish Mahadevan 2018-10-03  352  	else if (xfer->rx_buf)
561de45f72bd5f Girish Mahadevan 2018-10-03  353  		m_cmd = SPI_RX_ONLY;
561de45f72bd5f Girish Mahadevan 2018-10-03  354  
561de45f72bd5f Girish Mahadevan 2018-10-03  355  	spi_tx_cfg &= ~CS_TOGGLE;
561de45f72bd5f Girish Mahadevan 2018-10-03  356  
561de45f72bd5f Girish Mahadevan 2018-10-03  357  	if (!(mas->cur_bits_per_word % MIN_WORD_LEN))
561de45f72bd5f Girish Mahadevan 2018-10-03  358  		len = xfer->len * BITS_PER_BYTE / mas->cur_bits_per_word;
561de45f72bd5f Girish Mahadevan 2018-10-03  359  	else
561de45f72bd5f Girish Mahadevan 2018-10-03  360  		len = xfer->len / (mas->cur_bits_per_word / BITS_PER_BYTE + 1);
561de45f72bd5f Girish Mahadevan 2018-10-03  361  	len &= TRANS_LEN_MSK;
561de45f72bd5f Girish Mahadevan 2018-10-03  362  
561de45f72bd5f Girish Mahadevan 2018-10-03  363  	mas->cur_xfer = xfer;
561de45f72bd5f Girish Mahadevan 2018-10-03  364  	if (m_cmd & SPI_TX_ONLY) {
561de45f72bd5f Girish Mahadevan 2018-10-03  365  		mas->tx_rem_bytes = xfer->len;
561de45f72bd5f Girish Mahadevan 2018-10-03  366  		writel(len, se->base + SE_SPI_TX_TRANS_LEN);
561de45f72bd5f Girish Mahadevan 2018-10-03  367  	}
561de45f72bd5f Girish Mahadevan 2018-10-03  368  
561de45f72bd5f Girish Mahadevan 2018-10-03  369  	if (m_cmd & SPI_RX_ONLY) {
561de45f72bd5f Girish Mahadevan 2018-10-03  370  		writel(len, se->base + SE_SPI_RX_TRANS_LEN);
561de45f72bd5f Girish Mahadevan 2018-10-03  371  		mas->rx_rem_bytes = xfer->len;
561de45f72bd5f Girish Mahadevan 2018-10-03  372  	}
561de45f72bd5f Girish Mahadevan 2018-10-03  373  	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
561de45f72bd5f Girish Mahadevan 2018-10-03  374  	mas->cur_mcmd = CMD_XFER;
561de45f72bd5f Girish Mahadevan 2018-10-03  375  	geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
561de45f72bd5f Girish Mahadevan 2018-10-03  376  
561de45f72bd5f Girish Mahadevan 2018-10-03  377  	/*
561de45f72bd5f Girish Mahadevan 2018-10-03  378  	 * TX_WATERMARK_REG should be set after SPI configuration and
561de45f72bd5f Girish Mahadevan 2018-10-03  379  	 * setting up GENI SE engine, as driver starts data transfer
561de45f72bd5f Girish Mahadevan 2018-10-03  380  	 * for the watermark interrupt.
561de45f72bd5f Girish Mahadevan 2018-10-03  381  	 */
561de45f72bd5f Girish Mahadevan 2018-10-03  382  	if (m_cmd & SPI_TX_ONLY)
561de45f72bd5f Girish Mahadevan 2018-10-03  383  		writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
365ef891fdac5e Douglas Anderson 2020-03-17  384  
365ef891fdac5e Douglas Anderson 2020-03-17 @385  	spin_unlock_irq(&mas->lock);
561de45f72bd5f Girish Mahadevan 2018-10-03  386  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
